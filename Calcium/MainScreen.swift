//
//  MainScreen.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import SwiftUI

protocol CalculatorButtonRepresentable {
    var displayingValue: String { get }
}

enum Digit: UInt {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case zero = 0
}

extension Digit: CalculatorButtonRepresentable {
    var displayingValue: String {
        String(rawValue)
    }
}

enum Operation {
    case plus
    case minus
    case multiply
    case divide
    case equals
}

extension Operation: CalculatorButtonRepresentable {
    var displayingValue: String {
        switch self {
            case .plus:
                return "+"
            case .minus:
                return "-"
            case .multiply:
                return "*"
            case .divide:
                return "/"
            case .equals:
                return "="
        }
    }
}

enum CalculatorButton {
    case digit(Digit)
    case clear
    case operation(Operation)
}

extension CalculatorButton: CalculatorButtonRepresentable {
    var displayingValue: String {
        switch self {
        case .digit(let value):
            return value.displayingValue
        case .clear:
            return "C"
        case .operation(let operation):
            return operation.displayingValue
        }
    }
}

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
                case .equals:
                    switch latestOperationButton {
                        case .operation(let operation) where operation == .minus:
                            displayingText = String(Int(leftValue)! - Int(displayingText)!)
                        case .operation(let operation) where operation == .plus:
                            displayingText = String(Int(leftValue)! + Int(displayingText)!)
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
                view(for: .operation(.equals))
            }
        }
    }
}
