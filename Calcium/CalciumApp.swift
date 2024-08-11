//
//  CalciumApp.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import CalciumCommon
import ComposableArchitecture
import Resolver
import SwiftUI

@main
struct CalciumApp: App {
    init() {
        Resolver.register { KMMCalculator() }
            .implements(Calculator.self)
    }

    var body: some Scene {
        WindowGroup {
            MainScreen(
                store: Store(initialState: MainReducer.State()) {
                    MainReducer()
                }
            )
        }
    }
}

@DependencyClient
struct CalculatorClient {
    var calculateValue: (String, String, CalciumCommon.Operation) -> String = { _, _, _ in "" }
}

extension DependencyValues {
    var calculator: CalculatorClient {
        get { self[CalculatorClient.self] }
        set { self[CalculatorClient.self] = newValue }
    }
}

extension CalculatorClient: DependencyKey {
    static let liveValue = CalculatorClient(
        calculateValue: {
            NativeCalculator().calculateValue(lhs: $0, rhs: $1, operation: $2)
        }
    )
}
