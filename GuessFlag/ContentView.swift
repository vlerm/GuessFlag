//
//  ContentView.swift
//  GuessFlag
//
//  Created by Вадим Лавор on 19.08.22.
//  Copyright © 2022 Вадим Лавор. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var listCountries = ["Russia", "USA", "Japan", "Canada", "Finland", "France", "Germany", "Spain", "Thailand", "UK", "Poland", "Australia", "Bulgaria", "China", "Cyprus", "Denmark", "Estonia", "Israel", "Latvia", "Portugal", "Romania", "Sweden", "Ukraine", "Albania", "Algeria", "Angola", "Argentina", "Armenia", "Azerbaijan", "Belgium", "Bolivia", "Botswana", "Brazil", "Burkina Faso", "Burundi", "Cameroon", "Chad", "Cuba", "Czech Republic", "Dominica", "England", "Eritrea", "Georgia", "Ghana", "Guinea", "Hong Kong", "Iceland", "Indonesia", "Iran", "Ireland", "Italy", "Jamaica", "Kazakhstan", "Kuwait", "Kyrgyzstan", "Laos", "Liberia", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia", "Mali", "Malta", "Micronesia", "Moldova", "Mongolia", "Morocco", "Nepal", "Nicaragua", "Niger", "North Korea", "Oman", "Paraguay", "Peru", "Puerto Rico", "Qatar", "Rwanda", "Scotland", "Serbia", "Singapore", "Slovakia", "Slovenia", "Somalia", "South Korea", "Sri Lanka", "Suriname", "Switzerland", "Syria", "Taiwan", "Tunisia", "Turkey", "Turkmenistan", "Uganda", "Uruguay", "Uzbekistan", "Vietnam", "Wales", "Yemen"].shuffled()
    
    @State private var rightAnswer = Int.random(in: 0...2)
    @State private var totalScore = Int()
    @State private var showingTotalScore = false
    @State private var scoreTitle = String()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 30) {
                VStack {
                    Text("Choose flag of country: ")
                        .foregroundColor(Color.primary)
                        .font(.headline)
                    Text(listCountries[rightAnswer])
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .animation(.easeInOut)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagButtonClicked(number)
                        self.showingTotalScore = true
                    }) {
                        Image(self.listCountries[number])
                            .renderingMode(.original)
                            .frame(width: 255, height: 130)
                            .clipShape(Capsule())
                            .overlay(Capsule()
                                        .stroke(Color.black, lineWidth: 2))
                            .shadow(color: .black, radius: 4)
                            .animation(.default)
                    }
                }
                Text("Score: \(totalScore)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .animation(.default)
            }
        } .alert(isPresented: $showingTotalScore) {
            Alert(title: Text(scoreTitle), message: Text("Score: \(totalScore)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            } )
        }
    }
    
    func askQuestion() {
        listCountries.shuffle()
        rightAnswer = Int.random(in: 0...2)
    }
    
    func flagButtonClicked(_ number: Int) {
        if number == rightAnswer {
            scoreTitle = "Good! This is correct answer!"
            totalScore += 1
        } else {
            scoreTitle = "Incorrect answer! This is flag of \(listCountries[number])"
            totalScore -= 1
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
