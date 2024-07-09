//
//  MainScreen.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import CalciumCommon
import ComposableArchitecture
import SwiftUI

extension Animation {
    static var calciumDefault: Animation {
        .easeIn(duration: 0.1)
    }
}

struct MainScreen: View {
    @Perception.Bindable var store: StoreOf<MainReducer>

    private func view(for calculatorButton: CalciumCommon.CalculatorButton, enabled: Bool) -> some View {
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
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    Text(store.state.displayingText)
                        .lineLimit(nil)
                }
                .frame(height: geometry.size.height / 8)

                HStack {
                    view(for: .SomeDigit(digit: .one), enabled: store.state.enabled1)
                    view(for: .SomeDigit(digit: .two), enabled: store.state.enabled2)
                    view(for: .SomeDigit(digit: .three), enabled: store.state.enabled3)
                }

                HStack {
                    view(for: .SomeDigit(digit: .four), enabled: store.state.enabled4)
                    view(for: .SomeDigit(digit: .five), enabled: store.state.enabled5)
                    view(for: .SomeDigit(digit: .six), enabled: store.state.enabled6)
                }

                HStack {
                    view(for: .SomeDigit(digit: .seven), enabled: store.state.enabled7)
                    view(for: .SomeDigit(digit: .eight), enabled: store.state.enabled8)
                    view(for: .SomeDigit(digit: .nine), enabled: store.state.enabled9)
                }

                HStack {
                    view(for: .SomeDigit(digit: .zero), enabled: store.state.enabled0)
                    view(for: .SomeOperation(operation: .factorial), enabled: store.state.enabledFactorial)
                    view(for: .Clear(), enabled: store.state.enabledClear)
                }

                HStack {
                    view(for: .SomeOperation(operation: .plus), enabled: store.state.enabledPlus)
                    view(for: .SomeOperation(operation: .minus), enabled: store.state.enabledMinus)
                    view(for: .SomeOperation(operation: .multiply), enabled: store.state.enabledMultiply)
                    view(for: .SomeOperation(operation: .divide), enabled: store.state.enabledDivide)
                    view(for: .SomeOperation(operation: .equals), enabled: store.state.enabledEquals)
                }
            }
        }
    }
}
