//
//  ContentView.swift
//  TriviaAppPt1
//
//  Created by Maria Perez on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Trivia Game")
                        .purpleTitle()
                    
                    Text("Ready to become part of the Scooby gang? Test your knowledge!")
                        .foregroundColor(Color(.black))
                        .bold()
                }
                
                NavigationLink {
                    TriviaView()
                        .environmentObject(triviaManager)
                } label: {
                    PrimaryButton(text: "Scooby Doo Bee Doo! Time to Play!")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("AccentColor"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
