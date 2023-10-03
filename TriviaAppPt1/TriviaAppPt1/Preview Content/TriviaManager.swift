//
//  TriviaManager.swift
//  TriviaAppPt1
//
//  Created by Maria Perez on 10/2/23.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject{
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    
    init() {
        Task.init{
            await fetchTrivial()
        }
    }
    
    func fetchTrivial() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=5&category=9&difficulty=medium&type=multiple") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from: data)
            
            DispatchQueue.main.async{
                self.trivia = decodedData.results
                self.length = self.trivia.count
                self.setQuestion()
            }
        }catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    func goToNextQuestion(){
        
        if index < trivia.count - 1 {
            
            index += 1
            setQuestion()
        } else{
            
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        
        if index < length {
            let currentTrivialQuestion = trivia[index]
            question = currentTrivialQuestion.formattedQuestion
            answerChoices = currentTrivialQuestion.answers
        }
        
    }
    
    func selectAnswer(answer: Answer){
        
        if !answerSelected {
            answerSelected = true
            goToNextQuestion()
            if answer.isCorrect {
                score += 1
            
            }
        }
        
        
    }
}





