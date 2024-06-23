//
//  CalciumApp.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@main
struct CalciumApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen(
                store: Store(initialState: MainReducer.State()) {}
            )
        }
    }
}
