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
    One(1),
    Two(2),
    Three(3),
    Four(4),
    Five(5),
    Six(6),
    Seven(7),
    Eight(8),
    Nine(9),
    Zero(0)
}

enum class Operation {
    Plus {
         override fun calculateValueKMM(lhs: String, rhs: String): String {
             return (BigDecimal.parseString(lhs) + BigDecimal.parseString(rhs)).toPlainString()
         }
         },
    Minus {
        override fun calculateValueKMM(lhs: String, rhs: String): String {
            return (BigDecimal.parseString(lhs) - BigDecimal.parseString(rhs)).toString()
        }
    },
    Multiply {
        override fun calculateValueKMM(lhs: String, rhs: String): String {
            return (BigDecimal.parseString(lhs) * BigDecimal.parseString(rhs)).toString()
        }
    },
    Divide {
        override fun calculateValueKMM(lhs: String, rhs: String): String {
            return (BigDecimal.parseString(lhs) / BigDecimal.parseString(rhs)).toString()
        }
    },
    Factorial {
        override fun calculateValueKMM(lhs: String, rhs: String): String {
            return ""
        }
    },
    Equals {
        override fun calculateValueKMM(lhs: String, rhs: String): String {
            return ""
        }
    };

    abstract fun calculateValueKMM(lhs: String, rhs: String): String
}

sealed class CalculatorButton {
    object Clear : CalculatorButton()
    class SomeDigit(val digit: Digit) : CalculatorButton()
    class SomeOperation(val operation: Operation) : CalculatorButton()
}
