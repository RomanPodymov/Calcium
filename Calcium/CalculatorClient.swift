//
//  CalculatorClient.swift
//  Calcium
//
//  Created by Roman Podymov on 11/08/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import CalciumCommon
import ComposableArchitecture
import Resolver

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
            @Injected var calculator: Calculator

            return calculator.calculateValue(lhs: $0, rhs: $1, operation: $2)
        }
    )
}

extension CalculatorClient: TestDependencyKey {
    static let previewValue = {
        @Injected var calculator: Calculator

        return Self(calculateValue: {
            NativeCalculator().calculateValue(lhs: $0, rhs: $1, operation: $2)
        })
    }()

    static let testValue = previewValue
}
