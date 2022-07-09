//
//  Score.swift
//  MBTI_Finder
//
//  Created by SeongMinK on 2022/06/18.
//

import Foundation

class Score: ObservableObject {
    var answers = [Float]()
    var scores: [Int] = [50, 50, 50, 50]
    var result = String()
    
    func resetProcess() {
        answers.removeAll()
        scores = [50, 50, 50, 50]
    }
    
    func prevButtonAction() {
        answers.removeLast()
    }
    
    func nextButtonAction(value: Float) {
        answers.append(value)
    }
    
    func getScores() -> [Int] {
        return scores
    }
    
    func getResult() -> String {
        return result
    }
    
    func resultProcess() {
        for index in 0..<answers.count {
            scores[index % 4] += Int(answers[index])
        }
        
        if scores == [50, 50, 50, 50] { self.result = "Failed" }
        
        var mbti: String = ""
        mbti.append(contentsOf: scores[0] > 50 ? "E" : "I")
        mbti.append(contentsOf: scores[1] > 50 ? "S" : "N")
        mbti.append(contentsOf: scores[2] > 50 ? "T" : "F")
        mbti.append(contentsOf: scores[3] > 50 ? "P" : "J")
        self.result = mbti
    }
    
    func getNickname(_ mbti: String) -> String {
        switch mbti {
        case "ESTP": return "활동가형"
        case "ESTJ": return "사업가형"
        case "ESFP": return "사교형"
        case "ESFJ": return "친선도모형"
        case "ENTP": return "발명가형"
        case "ENTJ": return "지도자형"
        case "ENFP": return "스파크형"
        case "ENFJ": return "언변능숙형"
        case "ISTP": return "백과사전형"
        case "ISTJ": return "소금형"
        case "ISFP": return "성인군자형"
        case "ISFJ": return "권력형"
        case "INTP": return "아이디어형"
        case "INTJ": return "과학자형"
        case "INFP": return "잔다르크형"
        case "INFJ": return "예언자형"
        default: return "No Value"
        }
    }
}
