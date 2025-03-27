//
//  MainReducer.swift
//  Calcium
//
//  Created by Roman Podymov on 24/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import BigNumber
@preconcurrency import CalciumCommon
import ComposableArchitecture

enum MainReducerError: Error {
    case invalidValues
}

@Reducer
struct MainReducer {
    @Dependency(\.calculator) var calculator

    @ObservableState
    struct State: Equatable {
        var enabled1 = true
        var enabled2 = true
        var enabled3 = true
        var enabled4 = true
        var enabled5 = true
        var enabled6 = true
        var enabled7 = true
        var enabled8 = true
        var enabled9 = true
        var enabled0 = true

        var enabledPlus = true
        var enabledMinus = true
        var enabledMultiply = true
        var enabledDivide = true
        var enabledFactorial = true

        var enabledClear = true
        var enabledEquals = true

        var leftValue: BInt?
        var displayingText = ""
        var latestOperationButton: CalciumCommon.CalculatorButton?

        nonisolated(unsafe) static let mainPaths: Set<WritableKeyPath<Self, Bool>> = [
            \.enabled1,
            \.enabled2,
            \.enabled3,
            \.enabled4,
            \.enabled5,
            \.enabled6,
            \.enabled7,
            \.enabled8,
            \.enabled9,
            \.enabled0,

            \.enabledPlus,
            \.enabledMinus,
            \.enabledMultiply,
            \.enabledDivide,
            \.enabledFactorial,
        ]

        nonisolated(unsafe) static let additionalPaths: Set<WritableKeyPath<Self, Bool>> = [
            \.enabledClear,
            \.enabledEquals,
        ]

        init() {
            for mainPath in Self.mainPaths.union(Self.additionalPaths) {
                self[keyPath: mainPath] = true
            }
        }

        private mutating func onDigitButtonPressed(value: CalciumCommon.Digit) {
            switch latestOperationButton {
            case let operation as CalciumCommon.CalculatorButton.SomeOperation where operation.operation == .equals:
                displayingText = ""
                latestOperationButton = nil
            default:
                break
            }
            displayingText += value.displayingValue
        }

        private mutating func onOperationButtonPressed(calculatorButton: CalciumCommon.CalculatorButton) {
            latestOperationButton = calculatorButton
            leftValue = .init(displayingText)
            displayingText = ""
            switch calculatorButton {
            case let operation as CalciumCommon.CalculatorButton.SomeOperation where operation.operation.isUnary:
                set(enabled: false, all: false)
            default:
                break
            }
        }

        mutating func set(enabled: Bool, all: Bool) {
            for mainPath in Self.mainPaths {
                self[keyPath: mainPath] = enabled
            }

            if all {
                for mainPath in Self.additionalPaths {
                    self[keyPath: mainPath] = enabled
                }
            }
        }

        mutating func onButtonPressed(calculatorButton: CalciumCommon.CalculatorButton) -> Operation? {
            switch calculatorButton {
            case let digit as CalciumCommon.CalculatorButton.SomeDigit:
                onDigitButtonPressed(value: digit.digit)
            case is CalciumCommon.CalculatorButton.Clear:
                leftValue = nil
                displayingText = ""
                latestOperationButton = nil
                set(enabled: true, all: true)
            case let operation as CalciumCommon.CalculatorButton.SomeOperation:
                switch operation.operation {
                case .plus, .minus, .multiply, .divide, .factorial:
                    onOperationButtonPressed(calculatorButton: calculatorButton)
                case .equals:
                    switch latestOperationButton {
                    case let latestOperation as CalciumCommon.CalculatorButton.SomeOperation:
                        return latestOperation.operation
                    default:
                        break
                    }
                default:
                    break
                }
            default:
                break
            }
            return nil
        }
    }

    enum Action {
        case pressButton(CalciumCommon.CalculatorButton)
        case calculated(BInt)
    }

    private enum CancelID { case calculateValue }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .pressButton(button):
                let lhs = state.leftValue
                let rhs = BInt(state.displayingText)
                if let operation = state.onButtonPressed(calculatorButton: button) {
                    state.set(enabled: false, all: true)
                    return .run { send in
                        guard let lhs, let rhs else {
                            throw MainReducerError.invalidValues
                        }
                        let value = await Task { @MainActor in
                            let result = calculator.calculateValue(
                                lhs.asString(radix: 10),
                                rhs.asString(radix: 10),
                                operation
                            )
                            return BInt(result) ?? .init()
                        }.value
                        await send(.calculated(value), animation: .calciumDefault)
                    }
                    .cancellable(id: CancelID.calculateValue, cancelInFlight: true)
                } else {
                    return .cancel(id: CancelID.calculateValue)
                }
            case let .calculated(value):
                state.displayingText = String(value)
                state.latestOperationButton = .SomeOperation(operation: .equals)
                state.set(enabled: true, all: true)
                return .none
            }
        }
    }
}
