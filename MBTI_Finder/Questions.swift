//
//  Questions.swift
//  MBTI_Finder
//
//  Created by SeongMinK on 2022/04/29.
//

import Foundation

class Questions: ObservableObject {
    let score = Score()
    
    let questions: [String] = [
        "E", "S", "T", "P",
        "E", "S", "T", "P",
        "E", "S", "T", "P",
        "E", "S", "T", "P"
    ]
    
    func getQuestionText(at questionIndex: Int) -> String {
        if questionIndex < questions.count {
            return questions[questionIndex]
        } else {
            return "It's done!"
        }
    }
    
    func getProgress(at questionIndex: Int) -> Float {
        return Float(questionIndex) / Float(questions.count)
    }
}
