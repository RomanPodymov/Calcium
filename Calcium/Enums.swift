//
//  Enums.swift
//  Calcium
//
//  Created by Roman Podymov on 05/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import BigNumber

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

enum Operation: Equatable {
    case plus
    case minus
    case multiply
    case divide
    case equals

    func calculateValue(lhs: BInt, rhs: BInt) -> BInt {
        switch self {
        case .plus:
            lhs + rhs
        case .minus:
            lhs - rhs
        case .multiply:
            lhs * rhs
        case .divide:
            lhs / rhs
        case .equals:
            0
        }
    }
}

extension Operation: CalculatorButtonRepresentable {
    var displayingValue: String {
        switch self {
        case .plus:
            "+"
        case .minus:
            "-"
        case .multiply:
            "*"
        case .divide:
            "/"
        case .equals:
            "="
        }
    }
}

enum CalculatorButton: Equatable {
    case digit(Digit)
    case clear
    case operation(Operation)
}

extension CalculatorButton: CalculatorButtonRepresentable {
    var displayingValue: String {
        switch self {
        case let .digit(value):
            value.displayingValue
        case .clear:
            "C"
        case let .operation(operation):
            operation.displayingValue
        }
    }
}
