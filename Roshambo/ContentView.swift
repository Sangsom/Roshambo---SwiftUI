//
//  ContentView.swift
//  Roshambo
//
//  Created by Rinalds Domanovs on 18/10/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: State Properties
    @State private var computerHand = Int.random(in: 0 ..< 3)
    @State private var playerHand = 0

    // MARK: Properties
    var hands = ["Rock", "Paper", "Scissors"]

    var body: some View {
        VStack {
            ForEach(hands, id: \.self) { hand in
                Button(action: {
                    print("Button was tapped \(hand)")
                }) {
                    Text(hand)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
