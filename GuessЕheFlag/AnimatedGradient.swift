//
//  AnimatedGradient.swift
//  GuessЕheFlag
//
//  Created by Никита Куприянов on 15.07.2023.
//

import SwiftUI

struct AnimatedGradient: View {
    @State private var start = 100
    @State private var end = 800
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .init(red: 0.1, green: 0.2, blue: 0.45), location: 0.0),
                .init(color: .init(red: 0.76, green: 0.2, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: CGFloat(start), endRadius: CGFloat(end))
            .ignoresSafeArea()
            .scaleEffect(1.5)
            .blur(radius: 30)
            .opacity(0.8)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 7).repeatForever()) {
                self.start = 200
                self.end = 700
            }
        }
    }
}


struct AnimatedGradient_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedGradient()
    }
}
