//
//  Enums.swift
//  Calcium
//
//  Created by Roman Podymov on 05/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

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
