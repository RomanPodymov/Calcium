//
//  MainReducer.swift
//  Calcium
//
//  Created by Roman Podymov on 24/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import BigNumber
import ComposableArchitecture

@Reducer
struct MainReducer {
    @ObservableState
    struct State: Equatable {
        var leftValue: BInt?
        var displayingText = ""
        var latestOperationButton: CalculatorButton?

        private mutating func onDigitButtonPressed(value: Digit) {
            switch latestOperationButton {
            case .operation(.equals):
                displayingText = ""
                latestOperationButton = nil
            default:
                break
            }
            displayingText += String(value.rawValue)
        }

        private mutating func onOperationButtonPressed(calculatorButton: CalculatorButton) {
            latestOperationButton = calculatorButton
            leftValue = .init(displayingText)
            displayingText = ""
        }

        mutating func onButtonPressed(calculatorButton: CalculatorButton) -> Operation? {
            switch calculatorButton {
            case let .digit(value):
                onDigitButtonPressed(value: value)
            case .clear:
                displayingText = ""
            case let .operation(value):
                switch value {
                case .plus:
                    onOperationButtonPressed(calculatorButton: calculatorButton)
                case .minus:
                    onOperationButtonPressed(calculatorButton: calculatorButton)
                case .multiply:
                    onOperationButtonPressed(calculatorButton: calculatorButton)
                case .divide:
                    onOperationButtonPressed(calculatorButton: calculatorButton)
                case .equals:
                    switch latestOperationButton {
                    case let .operation(operation):
                        return operation
                    default:
                        break
                    }
                }
            }
            return nil
        }
    }

    enum Action: Sendable {
        case pressButton(CalculatorButton)
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
                    return .run { send in
                        let value = await Task {
                            operation.calculateValue(
                                lhs: lhs!,
                                rhs: rhs!
                            )
                        }.value
                        await send(.calculated(value), animation: .calciumDefault)
                    }
                    .cancellable(id: CancelID.calculateValue, cancelInFlight: true)
                } else {
                    return .cancel(id: CancelID.calculateValue)
                }
            case let .calculated(value):
                state.displayingText = String(value)
                state.latestOperationButton = .operation(.equals)
                return .none
            }
        }
    }
}

extension BInt: @unchecked Sendable {}
