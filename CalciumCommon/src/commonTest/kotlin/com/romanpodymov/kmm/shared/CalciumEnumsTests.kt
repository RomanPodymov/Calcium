//
//  CalciumEnumsTests.kt
//  Calcium
//
//  Created by Roman Podymov on 01/07/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

package com.romanpodymov.kmm.shared

import kotlin.test.Test
import kotlin.test.assertTrue

class CalciumEnumsTests {
    @Test
    fun valuesTest() {
        assertTrue {
            val one = Digit.One
            val two = Digit.Two
            one.value + two.value == 3
        }
    }

    @Test
    fun calculateValuesTest() {
        assertTrue {
            val operation = Operation.Plus
            operation.calculateValueKMM("1", "2") == "3"
        }
    }
}