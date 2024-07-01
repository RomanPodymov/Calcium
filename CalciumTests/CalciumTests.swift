//
//  CalciumTests.swift
//  CalciumTests
//
//  Created by Roman Podymov on 06/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

@testable import CalciumApp
import CalciumCommon
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
        store.send(.pressButton(.SomeDigit(digit: .one)))
        XCTAssertEqual(
            screen.store.state.displayingText,
            CalciumCommon.CalculatorButton.SomeDigit(digit: .one).displayingValue
        )
    }

    @MainActor
    func testStateComplex() async throws {
        let store = Store(initialState: MainReducer.State()) {
            MainReducer()
        }
        let screen = MainScreen(
            store: store
        )
        store.send(.pressButton(.SomeDigit(digit: .one)))
        store.send(.pressButton(.SomeOperation(operation: .plus)))
        store.send(.pressButton(.SomeDigit(digit: .two)))
        store.send(.pressButton(.SomeOperation(operation: .equals)))

        try await Task.sleep(nanoseconds: 1_000_000_000)

        XCTAssertEqual(screen.store.state.displayingText, String(1 + 2))
    }
}
