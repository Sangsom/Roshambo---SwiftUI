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
    @State private var shouldWin = false
    @State private var playerHand = ""
    @State private var playerScore = 0
    @State private var showingAlert = false

    // MARK: Properties
    var hands = ["Rock", "Paper", "Scissors"]

    var body: some View {
        VStack {
            Text("You have to \(shouldWin ? "win" : "lose") this round")
                .font(.title)

            ForEach(hands, id: \.self) { hand in
                Button(action: {
                    self.playerHand = hand

                    print("You chose \(hand), but computer chose \(self.hands[self.computerHand])")
                    self.showingAlert = true
                }) {
                    Text(hand)
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Result"),
                message: Text("Hola"),
                dismissButton: .default(Text("Ok"), action: {
                    self.nextRound()
                }))
        }
    }

    func nextRound() {
        computerHand = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
