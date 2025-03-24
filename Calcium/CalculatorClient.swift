//
//  CalculatorClient.swift
//  Calcium
//
//  Created by Roman Podymov on 11/08/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import CalciumCommon
import ComposableArchitecture
@preconcurrency import Resolver

@DependencyClient
struct CalculatorClient: Sendable, DependencyKey, TestDependencyKey {
    var calculateValue: @Sendable (String, String, CalciumCommon.Operation) -> String = { _, _, _ in "" }

    static let previewValue = CalculatorClient(
        calculateValue: {
            Resolver.resolve(
                Calculator.self,
                name: .name(fromString: "calculator")
            ).calculateValue(lhs: $0, rhs: $1, operation: $2)
        }
    )

    static let liveValue = CalculatorClient(
        calculateValue: {
            Resolver.resolve(
                Calculator.self,
                name: .name(fromString: "calculator")
            ).calculateValue(lhs: $0, rhs: $1, operation: $2)
        }
    )

    static let testValue = previewValue
}

extension DependencyValues {
    var calculator: CalculatorClient {
        get { self[CalculatorClient.self] }
        set { self[CalculatorClient.self] = newValue }
    }
}
