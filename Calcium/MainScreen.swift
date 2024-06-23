//
//  MainScreen.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct MainScreen: View {
    @State
    var presenter = MainPresenter()

    @Perception.Bindable var store: StoreOf<MainReducer>

    private func view(for calculatorButton: CalculatorButton) -> some View {
        Button {
            switch calculatorButton {
            case let .digit(value):
                presenter.onDigitButtonPressed(value: value)
            case .clear:
                presenter.displayingText = ""
            case let .operation(value):
                switch value {
                case .plus:
                    presenter.onOperationButtonPressed(calculatorButton: calculatorButton)
                case .minus:
                    presenter.onOperationButtonPressed(calculatorButton: calculatorButton)
                case .multiply:
                    presenter.onOperationButtonPressed(calculatorButton: calculatorButton)
                case .divide:
                    presenter.onOperationButtonPressed(calculatorButton: calculatorButton)
                case .equals:
                    switch presenter.latestOperationButton {
                    case let .operation(operation):
                        presenter.displayingText = String(operation.calculateValue(
                            lhs: Int(presenter.leftValue)!,
                            rhs: Int(presenter.displayingText)!
                        )
                        )
                    default:
                        break
                    }
                    presenter.latestOperationButton = .operation(.equals)
                }
            }
        } label: {
            Text(calculatorButton.displayingValue)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.green)
    }

    var body: some View {
        VStack {
            Text(presenter.displayingText)

            HStack {
                view(for: .digit(.one))
                view(for: .digit(.two))
                view(for: .digit(.three))
            }

            HStack {
                view(for: .digit(.four))
                view(for: .digit(.five))
                view(for: .digit(.six))
            }

            HStack {
                view(for: .digit(.seven))
                view(for: .digit(.eight))
                view(for: .digit(.nine))
            }

            HStack {
                view(for: .digit(.zero))
                view(for: .clear)
            }

            HStack {
                view(for: .operation(.plus))
                view(for: .operation(.minus))
                view(for: .operation(.multiply))
                view(for: .operation(.divide))
                view(for: .operation(.equals))
            }
        }
    }
}
