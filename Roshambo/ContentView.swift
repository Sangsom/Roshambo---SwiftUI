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
    @State private var round = 1 {
        didSet {
            computerHand = Int.random(in: 0 ..< 3)
            shouldWin = Bool.random()
        }
    }
    @State private var endGame = false
    @State private var showingAlert = false

    // MARK: Properties
    var hands = ["Rock", "Paper", "Scissors"]
    var maxRounds = 3

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
                    if self.round < self.maxRounds {
                        self.round += 1
                    } else {
                        self.endGame = true
                    }
                }) {
                    Text(hand)
                }

            }

            Text("Current Round: \(round)")
        }
        .alert(isPresented: $endGame) {
            Alert(
                title: Text("Game Over"),
                message: Text("Congratulations mate, your score is \(self.playerScore)"),
                dismissButton: .default(Text("Restart"), action: {
                    self.restartGame()
            }))
        }
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
    }

    func decrementScore() {
        playerScore -= 1
    }

    func restartGame() {
        round = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
