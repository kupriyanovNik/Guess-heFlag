//
//  ContentView.swift
//  GuessЕheFlag
//
//  Created by Никита Куприянов on 13.07.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    
    @State private var currentQuestion: Int = 0
    @State private var score: Int = 0
    
    @State private var isEnded: Bool = false
    
    @State private var counties: [String] = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()
    @State private var currentQuestionCounties: [String] = []
    @State private var correctAnswer: String = ""
    
    var body: some View {
        
        ZStack {
            AnimatedGradient()
            VStack {
                
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 30) {
                    
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(correctAnswer)
                            .font(.largeTitle.weight(.semibold))
                    }
                        
                    
                    ForEach(currentQuestionCounties, id: \.self) { country in
                        Button {
                            flagTapped(country)
                        } label: {
                            Image(country)
                                .renderingMode(.original)
    //                            .clipShape(Capsule())
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }

                    }
                }
                .onAppear {
                    askQuestion()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .cornerRadius(10)
//            .padding(.horizontal)
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                
            }
            .padding( )
            
        }
        .alert("Game ended", isPresented: $isEnded) {
            Button("New game", action: newGame)
        } message: {
            Text("Your score: \(score)/10")
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ country: String) {
        withAnimation {
            self.currentQuestion += 1
            switch country {
            case correctAnswer:
                self.scoreTitle = "Correct"
                self.score += 1
            default:
                self.scoreTitle = "Wrong"
            }
            self.showingScore = true
            if self.currentQuestion == 10 {
                self.isEnded = true
            }
        }
    }
    func askQuestion() {
        self.currentQuestionCounties = [
            self.counties.randomElement()!,
            self.counties.randomElement()!,
            self.counties.randomElement()!
        ]
        self.correctAnswer = currentQuestionCounties.randomElement()!
    }
    func newGame() {
        self.score = 0
        self.currentQuestion = 0
        self.counties.shuffle()
        self.correctAnswer = currentQuestionCounties.randomElement()!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
