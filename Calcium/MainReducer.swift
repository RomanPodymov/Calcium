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

        mutating func onButtonPressed(calculatorButton: CalculatorButton) {
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
                        displayingText = String(
                            operation.calculateValue(
                                lhs: leftValue!,
                                rhs: BInt(displayingText)!
                            )
                        )
                    default:
                        break
                    }
                    latestOperationButton = .operation(.equals)
                }
            }
        }
    }

    enum Action: Sendable {
        case pressButton(CalculatorButton)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .pressButton(button):
                state.onButtonPressed(calculatorButton: button)
                return .none
            }
        }
    }
}
