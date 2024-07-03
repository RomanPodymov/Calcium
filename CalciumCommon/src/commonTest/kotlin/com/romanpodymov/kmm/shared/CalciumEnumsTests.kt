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
            val one = Digit.one
            val two = Digit.two
            one.value + two.value == 3
        }
    }
}