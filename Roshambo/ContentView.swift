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
    @State private var hands = ["Rock", "Paper", "Scissors"]
    @State private var computerHand = Int.random(in: 0 ..< 3)
    @State private var shouldWin = false
    @State private var playerHand = ""
    @State private var playerScore = 0
    @State private var round = 1 {
        didSet {
            hands.shuffle()
            computerHand = Int.random(in: 0 ..< 3)
            shouldWin = Bool.random()
        }
    }
    @State private var endGame = false
    @State private var showingAlert = false

    // MARK: Properties
    var maxRounds = 3

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "EAD6EE"), Color(hex: "A0F1EA")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            VStack {
                Text("I will go with \(hands[computerHand]). \(shouldWin ? "I shall win!" : "Beat me!")")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)

                ForEach(hands, id: \.self) { hand in
                    Button(action: {
                        self.playerHand = hand

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
                        Image(hand)
                            .renderingMode(.original)
                    }

                }

                HStack {
                    Text("Current Round: \(round)")
                    Spacer()
                    Text("Score: \(playerScore)")
                }
                .padding()
                .font(.headline)
                .foregroundColor(.secondary)

            }
        }
        .edgesIgnoringSafeArea(.all)
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
            case ("Rock", "Scissors"):
                incrementScore()
            case ("Paper", "Rock"):
                incrementScore()
            case ("Scissors", "Paper"):
                incrementScore()
            default:
                decrementScore()
            }
        } else {
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
        playerScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff


        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)

    }
}
