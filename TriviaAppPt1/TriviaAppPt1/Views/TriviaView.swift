//
//  TriviaView.swift
//  TriviaAppPt1
//
//  Created by Maria Perez on 10/2/23.
//

import SwiftUI

import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager

    var body: some View {
        if triviaManager.reachedEnd {
            VStack(spacing: 20) {
                Text("Trivia Game")
                    .purpleTitle()

                Text("Now you are part of the Scooby gang!")
                
                Text("You scored \(triviaManager.score) out of \(triviaManager.length)")
                
                Button {
                    Task.init {
                        await triviaManager.fetchTrivial()
                    }
                } label: {
                    PrimaryButton(text: "Play again")
                }
            }
            .foregroundColor(Color(.black))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("AccentColor"))
        } else {
            QuestionView()
                .environmentObject(triviaManager)
        }
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager())
    }
}


