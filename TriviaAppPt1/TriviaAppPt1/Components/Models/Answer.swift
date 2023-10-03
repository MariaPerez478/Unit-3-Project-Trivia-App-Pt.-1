//
//  Answer.swift
//  TriviaAppPt1
//
//  Created by Maria Perez on 10/2/23.
//

import Foundation

struct Answer: Identifiable{
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}
