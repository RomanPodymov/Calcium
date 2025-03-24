//
//  Enums.swift
//  Calcium
//
//  Created by Roman Podymov on 05/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import BigNumber
import CalciumCommon

class NativeCalculator: CalciumCommon.Calculator {
    func calculateValue(lhs: String, rhs: String, operation: CalciumCommon.Operation) -> String {
        .init(
            operation.calculateValue(
                lhs: .init(lhs) ?? .init(),
                rhs: .init(rhs) ?? .init()
            )
        )
    }
}

extension CalciumCommon.Digit: CalciumCommon.CalculatorButtonRepresentable {
    public var displayingValue: String {
        String(value)
    }
}

extension CalciumCommon.Operation {
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
        default:
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

extension CalciumCommon.Operation: CalciumCommon.CalculatorButtonRepresentable {
    public var displayingValue: String {
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
        default:
            ""
        }
    }
}

extension CalciumCommon.CalculatorButton: CalciumCommon.CalculatorButtonRepresentable {
    public var displayingValue: String {
        switch self {
        case let digit as CalciumCommon.CalculatorButton.SomeDigit:
            digit.digit.displayingValue
        case is CalciumCommon.CalculatorButton.Clear:
            "C"
        case let operation as CalciumCommon.CalculatorButton.SomeOperation:
            operation.operation.displayingValue
        default:
            ""
        }
    }
}
