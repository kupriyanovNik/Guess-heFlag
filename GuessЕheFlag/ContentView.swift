//
//  ContentView.swift
//  GuessЕheFlag
//
//  Created by Никита Куприянов on 13.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showAnimation = false
    @State private var mainAnimationValue = 0.0
    @State private var countries = [
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
        "US",
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore: Bool = false
    @State private var isGameEnded: Bool = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    @State private var currentQuestionNumber: Int = 1
    @State private var selectedId = ""
    
    var body: some View {
        ZStack {
            AnimatedGradient()
            
            VStack {
                Text("Guess The Flag")
                    .makeLargeAndBlue()
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        FlagImage(image: countries[number]) { flagID in
                            withAnimation(.easeOut(duration: 0.5)) {
                                
                                self.showAnimation = true
                            }
                            flagTapped(number)
                        }
                        .rotation3DEffect(.degrees(number == self.correctAnswer && self.showAnimation ? 360 : 0.0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number != self.correctAnswer && self.showAnimation ? 0.75 : 1)
                        .scaleEffect(number != self.correctAnswer && self.showAnimation ? 0.75 : 1)
                    }
                }
                .foregroundColor(.white)
                .padding(40)
                .padding(.horizontal, 25)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                
                Text("My score: \(score)")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Text("Question number: \(currentQuestionNumber)")
                    .font(.subheadline.weight(.heavy))
                    .foregroundStyle(.secondary)
            }
        }
        .animation(.linear, value: selectedId)
        .onAppear {
            countries.shuffle()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game ended", isPresented: $isGameEnded) {
            Button("New game", action: reset)
        } message: {
            Text("Your score: \(score)/10")
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedId = ""
        currentQuestionNumber += 1
        if number == correctAnswer {
            scoreTitle = "Cool."
            score += 1
        } else {
            scoreTitle = "Wrong."
        }
        showingScore = true
        if currentQuestionNumber == 10 {
            isGameEnded = true
        }
    }
    
    func askQuestion() {
        showAnimation = false
        mainAnimationValue = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        askQuestion()
        score = 0
        currentQuestionNumber = 0
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct FlagImage: View {
    let id = UUID().uuidString
    let image: String
    @State private var ownOpacity: Double = 1
    let callback: (String) -> ()
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .cornerRadius(10)
            .shadow(radius: 5)
            .onTapGesture {
                callback(id)
            }
//            .gesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { _ in ownOpacity = 0.5 }
//                    .onEnded { _ in
//                        ownOpacity = 1
//                        callback(id)
//                    }
//            )
    }
}


struct LargeAndBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func makeLargeAndBlue() -> some View {
        modifier(LargeAndBlueTitle())
    }
}
