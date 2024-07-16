//
//  CalciumEnums.kt
//  Calcium
//
//  Created by Roman Podymov on 01/07/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

package com.romanpodymov.kmm.shared

import com.ionspin.kotlin.bignum.*

interface CalculatorButtonRepresentable {
    val displayingValue: String
}

enum class Digit(val value: Int) {
    one(1),
    two(2),
    three(3),
    four(4),
    five(5),
    six(6),
    seven(7),
    eight(8),
    nine(9),
    zero(0)
}

enum class Operation {
    plus,
    minus,
    multiply,
    divide,
    factorial,
    equals
}

sealed class CalculatorButton {
    object Clear : CalculatorButton()
    class SomeDigit(val digit: Digit) : CalculatorButton()
    class SomeOperation(val operation: Operation) : CalculatorButton()
}
