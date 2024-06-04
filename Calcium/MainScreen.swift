//
//  MainScreen.swift
//  Calcium
//
//  Created by Roman Podymov on 04/06/2024.
//  Copyright © 2024 Calcium. All rights reserved.
//

import SwiftUI

struct MainScreen: View {
    @State
    var displayingText = ""

    private func button(for text: String) -> some View {
        Button(text) {
            displayingText += text
        }
        .scaledToFit()
        .frame(idealWidth: 200)
    }

    var body: some View {
        VStack {
            Text(displayingText)

            HStack {
                button(for: "1")
                button(for: "2")
                button(for: "3")
            }

            HStack {
                button(for: "4")
                button(for: "5")
                button(for: "6")
            }

            HStack {
                button(for: "7")
                button(for: "8")
                button(for: "9")
            }
        }
    }
}
