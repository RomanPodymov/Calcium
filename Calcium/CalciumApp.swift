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
        Resolver.register(Calculator.self, name: .name(fromString: "calculator")) {
            NativeCalculator()
        }
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
