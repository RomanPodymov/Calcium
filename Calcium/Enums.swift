//
//  Enums.swift
//  Calcium
//
//  Created by Roman Podymov on 05/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import BigNumber
import CalciumCommon

protocol CalculatorButtonRepresentable {
    var displayingValue: String { get }
}

extension CalciumCommon.Digit: CalculatorButtonRepresentable {
    var displayingValue: String {
        String(value)
    }
}

enum Operation: Equatable {
    case plus
    case minus
    case multiply
    case divide
    case factorial
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
        case .factorial:
            lhs.factorial()
        case .equals:
            0
        }
    }

    var isUnary: Bool {
        switch self {
        case .factorial:
            true
        default:
            false
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
        case .factorial:
            "!"
        case .equals:
            "="
        }
    }
}

enum CalculatorButton: Equatable {
    case digit(CalciumCommon.Digit)
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
