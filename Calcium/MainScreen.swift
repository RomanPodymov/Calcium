//
//  MainScreen.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import SwiftUI

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

enum CalculatorButton {
    case digit(Digit)
    case clear
    case plus
    case minus
    case equals

    var text: String {
        switch self {
        case .digit(let value):
            return String(value.rawValue)
        case .clear:
            return "C"
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .equals:
            return "="
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
            case .plus:
                latestOperationButton = .plus
                leftValue = displayingText
                displayingText = ""
            case .minus:
                latestOperationButton = .minus
                leftValue = displayingText
                displayingText = ""
            case .equals:
                switch latestOperationButton {
                    case .minus:
                        displayingText = String(Int(leftValue)! - Int(displayingText)!)
                    case .plus:
                        displayingText = String(Int(leftValue)! + Int(displayingText)!)
                    default:
                        break
                }
            }
        } label: {
            Text(calculatorButton.text)
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
                view(for: .plus)
                view(for: .minus)
                view(for: .equals)
            }
        }
    }
}
