//
//  Score.swift
//  MBTI_Finder
//
//  Created by SeongMinK on 2022/06/18.
//

import Foundation

class Score: ObservableObject {
    var scores: [Int] = [50, 50, 50, 50]
    
    func yesButtonAction(_ questionIndex: Int) {
        scores[questionIndex % 4] += 1
    }
    
    func noButtonAction(_ questionIndex: Int) {
        scores[questionIndex % 4] -= 1
    }
    
    func getScores() -> [Int] {
        return scores
    }
    
    func getResult() -> String {
        var result: String = ""
        result.append(contentsOf: scores[0] > 50 ? "E" : "I")
        result.append(contentsOf: scores[1] > 50 ? "S" : "N")
        result.append(contentsOf: scores[2] > 50 ? "T" : "F")
        result.append(contentsOf: scores[3] > 50 ? "P" : "J")
        return result
    }
}
