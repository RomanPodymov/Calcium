//
//  MainPresenter.swift
//  Calcium
//
//  Created by Roman Podymov on 07/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct MainReducer {
    @ObservableState
    struct State: Equatable {
        var displayingText = ""
    }

    enum Action: Sendable {
        case evaluate
    }

    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            case .evaluate:
                .none
            }
        }
    }
}

struct MainPresenter {
    var leftValue = ""
    var displayingText = ""
    var latestOperationButton: CalculatorButton?

    mutating func onDigitButtonPressed(value: Digit) {
        switch latestOperationButton {
        case .operation(.equals):
            displayingText = ""
            latestOperationButton = nil
        default:
            break
        }
        displayingText += String(value.rawValue)
    }

    mutating func onOperationButtonPressed(calculatorButton: CalculatorButton) {
        latestOperationButton = calculatorButton
        leftValue = displayingText
        displayingText = ""
    }
}
