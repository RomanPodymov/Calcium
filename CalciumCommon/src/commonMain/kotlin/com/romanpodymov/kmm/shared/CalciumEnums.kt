//
//  CalciumEnums.kt
//  Calcium
//
//  Created by Roman Podymov on 01/07/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

package com.romanpodymov.kmm.shared

import com.ionspin.kotlin.bignum.decimal.BigDecimal

interface CalculatorButtonRepresentable {
    val displayingValue: String
}

enum class Digit(val value: Int) {
    ONE(1),
    TWO(2),
    THREE(3),
    FOUR(4),
    FIVE(5),
    SIX(6),
    SEVEN(7),
    EIGHT(8),
    NINE(9),
    ZERO(0)
}

enum class Operation {
    PLUS {
         override fun calculateValueKMM(lhs: BigDecimal, rhs: BigDecimal): BigDecimal {
             return lhs + rhs
         }
         },
    MINUS {
        override fun calculateValueKMM(lhs: BigDecimal, rhs: BigDecimal): BigDecimal {
            return lhs - rhs
        }
    },
    MULTIPLY {
        override fun calculateValueKMM(lhs: BigDecimal, rhs: BigDecimal): BigDecimal {
            return lhs * rhs
        }
    },
    DIVIDE {
        override fun calculateValueKMM(lhs: BigDecimal, rhs: BigDecimal): BigDecimal {
            return lhs / rhs
        }
    },
    FACTORIAL {
        override fun calculateValueKMM(lhs: BigDecimal, rhs: BigDecimal): BigDecimal {
            return BigDecimal.ZERO
        }
    },
    EQUALS {
        override fun calculateValueKMM(lhs: BigDecimal, rhs: BigDecimal): BigDecimal = BigDecimal.ZERO
    };

    internal abstract fun calculateValueKMM(lhs: BigDecimal, rhs: BigDecimal): BigDecimal
}

sealed class CalculatorButton {
    object Clear : CalculatorButton()
    class SomeDigit(val digit: Digit) : CalculatorButton()
    class SomeOperation(val operation: Operation) : CalculatorButton()
}

interface Calculator {
    fun calculateValue(lhs: String, rhs: String, operation: Operation): String
}

class KMMCalculator: Calculator {
    override fun calculateValue(lhs: String, rhs: String, operation: Operation): String {
        return operation.calculateValueKMM(
            BigDecimal.parseString(lhs),
            BigDecimal.parseString(rhs)
        ).toPlainString()
    }
}