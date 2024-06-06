//
//  MainScreen.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import SwiftUI

struct MainScreen: View {
    @State
    private var leftValue = ""

    @State
    var displayingText = ""

    @State
    private var latestOperationButton: CalculatorButton?

    private func view(for calculatorButton: CalculatorButton) -> some View {
        Button {
            switch calculatorButton {
                case .digit(let value):
                    displayingText += String(value.rawValue)
                case .clear:
                    displayingText = ""
            case .operation(let value):
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
                        case .operation(let operation) where operation == .minus:
                            displayingText = String(Int(leftValue)! - Int(displayingText)!)
                        case .operation(let operation) where operation == .plus:
                            displayingText = String(Int(leftValue)! + Int(displayingText)!)
                        case .operation(let operation) where operation == .multiply:
                            displayingText = String(Int(leftValue)! * Int(displayingText)!)
                        case .operation(let operation) where operation == .divide:
                            displayingText = String(Int(leftValue)! / Int(displayingText)!)
                        default:
                            break
                    }
                }
            }
        } label: {
            Text(calculatorButton.displayingValue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.green)
    }

    private func onOperationButtonPressed(calculatorButton: CalculatorButton) {
        latestOperationButton = calculatorButton
        leftValue = displayingText
        displayingText = ""
    }

    var body: some View {
        VStack {
            Text(displayingText)

            HStack {
                view(for: .digit(.one))
                view(for: .digit(.two))
                view(for: .digit(.three))
            }

            HStack {
                view(for: .digit(.four))
                view(for: .digit(.five))
                view(for: .digit(.six))
            }

            HStack {
                view(for: .digit(.seven))
                view(for: .digit(.eight))
                view(for: .digit(.nine))
            }

            HStack {
                view(for: .digit(.zero))
                view(for: .clear)
            }

            HStack {
                view(for: .operation(.plus))
                view(for: .operation(.minus))
                view(for: .operation(.multiply))
                view(for: .operation(.divide))
                view(for: .operation(.equals))
            }
        }
    }
}
