//
//  ContentView.swift
//  MBTI_Finder
//
//  Created by 김성민 on 2022/03/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var questions = Questions()
    @ObservedObject var score = Score()
    @State var questionIndex: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(red: 0.10, green: 0.74, blue: 0.61, alpha: 1.00))
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text(questions.getQuestionText(at: questionIndex))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding()
                        .background(.secondary)
                        .cornerRadius(15)
                    Spacer()
                    HStack(spacing: 20) {
                        Button("Yes") {
                            score.yesButtonAction(questionIndex)
                            questionIndex += 1
                            if (questions.questions.count <= questionIndex) {
                                print(score.getResult())
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.primary)
                        .foregroundColor(.white)
                        Button("No") {
                            score.noButtonAction(questionIndex)
                            questionIndex += 1
                            if (questions.questions.count <= questionIndex) {
                                print(score.getResult())
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.primary)
                        .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()
                .navigationBarTitle("MBTI Finder")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
