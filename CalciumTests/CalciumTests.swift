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

    @MainActor
    func testStateComplex() async throws {
        let store = Store(initialState: MainReducer.State()) {
            MainReducer()
        }
        let screen = MainScreen(
            store: store
        )
        store.send(.pressButton(.digit(.one)))
        store.send(.pressButton(.operation(.plus)))
        store.send(.pressButton(.digit(.two)))
        store.send(.pressButton(.operation(.equals)))

        try await Task.sleep(nanoseconds: 1_000_000_000)

        XCTAssertEqual(screen.store.state.displayingText, String(1 + 2))
    }
}
