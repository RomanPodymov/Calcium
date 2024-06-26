//
//  CalciumTests.swift
//  CalciumTests
//
//  Created by Roman Podymov on 06/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

@testable import CalciumApp
import ComposableArchitecture
import XCTest

class CalciumTests: XCTestCase {
    func testState() {
        let store = Store(initialState: MainReducer.State()) {
            MainReducer()
        }
        let screen = MainScreen(
            store: store
        )
        store.send(.pressButton(.digit(.one)))
        XCTAssertEqual(screen.store.state.displayingText, CalculatorButton.digit(.one).displayingValue)
    }
}
