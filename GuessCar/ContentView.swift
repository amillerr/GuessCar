//
//  ContentView.swift
//  GuessCar
//
//  Created by Artem Axenov on 2022-10-19.
//

import SwiftUI

struct ContentView: View {

    @State private var cars = ["Acura", "Brilliance", "Cadillac", "DMC", "GreatWall", "Hyundai", "Infiniti", "Jaguar", "Koenigsegg", "Lada", "Maybach", "Peugeot", "Seat", "Tesla", "UAZ", "Vauxhall"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("color2"), Color("color1")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Choose the right logo: ")
                        .foregroundColor(.white)
                        .font(.headline)

                    Text(cars[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.logoTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.cars[number])
                            .resizable()
                            .frame(width: 280, height: 140)
                            .clipShape(Capsule())
                            .shadow(color: .white, radius: 2)
                    }
                }
                Text("Total score: \(score)")
                    .foregroundColor(.white)
                    .fontWeight(.black)
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message:
                    Text("Total score: \(score)"), dismissButton:
                    .default(Text("Continue")) {
                        self.askQuestion()
                    })
            }
        }
    
    func askQuestion() {
        cars.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func logoTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct answer"
            score += 1
        } else {
            scoreTitle = "Wrong answer! It is: \(cars[number])"
            score -= 1
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
