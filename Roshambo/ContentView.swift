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
    @State private var alertTitle = ""
    @State private var alertMessage = ""

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

                    // Determine if the player won or lost
                    self.compareHands(
                        player: self.playerHand,
                        computer: self.hands[self.computerHand])

                    // Update score
                    self.showingAlert = true
                }) {
                    Text(hand)
                }
            }

            Text("Score: \(playerScore)")
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("Continue"), action: {
                    self.nextRound()
                }))
        }
    }

    func nextRound() {
        computerHand = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }

    func compareHands(player: String, computer: String) {
        if shouldWin {
            switch(computer, player) {
            case ("Rock", "Paper"):
                incrementScore()
            case ("Paper", "Scissors"):
                incrementScore()
            case ("Scissors", "Rock"):
                incrementScore()
            default:
                decrementScore()
            }
        } else {
            switch(computer, player) {
            case ("Rock", "Scissors"):
                incrementScore()
            case ("Paper", "Rock"):
                incrementScore()
            case ("Scissors", "Paper"):
                incrementScore()
            default:
                decrementScore()
            }
        }
    }

    func incrementScore() {
        playerScore += 1
        alertTitle = "You won"
        alertMessage = "Woohoo! +1 to score."
    }

    func decrementScore() {
        playerScore -= 1
        alertTitle = "You lost"
        alertMessage = "Sorry mate -1 lost from score."
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
