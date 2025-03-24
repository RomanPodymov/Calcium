//
//  CalciumEnumsTests.kt
//  Calcium
//
//  Created by Roman Podymov on 01/07/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

package com.romanpodymov.kmm.shared

import com.ionspin.kotlin.bignum.decimal.BigDecimal
import com.ionspin.kotlin.bignum.decimal.toBigDecimal
import kotlin.test.Test
import kotlin.test.assertTrue

class CalciumEnumsTests {
    @Test
    fun valuesTest() {
        assertTrue {
            val one = Digit.ONE
            val two = Digit.TWO
            one.value + two.value == 3
        }
    }

    @Test
    fun calculateValuesTest() {
        assertTrue {
            val operation = Operation.PLUS
            operation.calculateValueKMM(BigDecimal.ONE, BigDecimal.TWO) == "3".toBigDecimal()
        }
    }
}