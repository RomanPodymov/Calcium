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
    var latestOperationButton: CalculatorButton?

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
                    latestOperationButton = calculatorButton
                    leftValue = displayingText
                    displayingText = ""
                case .minus:
                    latestOperationButton = calculatorButton
                    leftValue = displayingText
                    displayingText = ""
                case .multiply:
                    latestOperationButton = calculatorButton
                    leftValue = displayingText
                    displayingText = ""
                case .divide:
                    latestOperationButton = calculatorButton
                    leftValue = displayingText
                    displayingText = ""
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
                default:
                    break
                }
            }
        } label: {
            Text(calculatorButton.displayingValue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.green)
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
