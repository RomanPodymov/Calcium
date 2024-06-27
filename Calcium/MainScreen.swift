//
//  MainScreen.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

extension Animation {
    static var calciumDefault: Animation {
        .easeIn(duration: 0.1)
    }
}

struct MainScreen: View {
    @Perception.Bindable var store: StoreOf<MainReducer>

    private func view(for calculatorButton: CalculatorButton, enabled: Bool = true) -> some View {
        Button {
            store.send(.pressButton(calculatorButton), animation: .calciumDefault)
        } label: {
            Text(calculatorButton.displayingValue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .disabled(!enabled)
        .background(.green)
    }

    var body: some View {
        VStack {
            Text(store.state.displayingText)

            HStack {
                view(for: .digit(.one), enabled: store.state.enabled1)
                view(for: .digit(.two), enabled: store.state.enabled2)
                view(for: .digit(.three), enabled: store.state.enabled3)
            }

            HStack {
                view(for: .digit(.four), enabled: store.state.enabled4)
                view(for: .digit(.five), enabled: store.state.enabled5)
                view(for: .digit(.six), enabled: store.state.enabled6)
            }

            HStack {
                view(for: .digit(.seven), enabled: store.state.enabled7)
                view(for: .digit(.eight), enabled: store.state.enabled8)
                view(for: .digit(.nine), enabled: store.state.enabled9)
            }

            HStack {
                view(for: .digit(.zero), enabled: store.state.enabled0)
                view(for: .operation(.factorial), enabled: store.state.enabledFactorial)
                view(for: .clear)
            }

            HStack {
                view(for: .operation(.plus), enabled: store.state.enabledPlus)
                view(for: .operation(.minus), enabled: store.state.enabledMinus)
                view(for: .operation(.multiply), enabled: store.state.enabledMultiply)
                view(for: .operation(.divide), enabled: store.state.enabledDivide)
                view(for: .operation(.equals))
            }
        }
    }
}
