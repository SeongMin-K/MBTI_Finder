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
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color(UIColor(red: 0.10, green: 0.74, blue: 0.61, alpha: 1.00))
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("\(questionIndex) / \(questions.questions.count) 문항")
                            .font(.system(size: 14, weight: .light, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        ProgressView(value: questions.getProgress(at: questionIndex))
                            .progressViewStyle(.linear)
                            .tint(.secondary)
                            .shadow(color: .primary, radius: 3, x: 1, y: 2)
                        Spacer()
                        Text(questions.getQuestionText(at: questionIndex))
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .padding()
                            .background(.secondary)
                            .cornerRadius(15)
                        Spacer()
                        HStack(spacing: 20) {
                            Button {
                                score.yesButtonAction(questionIndex)
                                if (questions.questions.count <= questionIndex) {
                                    print(score.getResult())
                                } else {
                                    questionIndex += 1
                                }
                            } label: {
                                Text("그렇다")
                                    .frame(width: geometry.size.width * 0.35, height: 40)
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                            }
                            .frame(maxWidth: .infinity)
                            .buttonStyle(.borderedProminent)
                            .tint(.black)
                            .foregroundColor(.white)
                            Button {
                                score.noButtonAction(questionIndex)
                                if (questions.questions.count <= questionIndex) {
                                    print(score.getResult())
                                } else {
                                    questionIndex += 1
                                }
                            } label: {
                                Text("아니다")
                                    .frame(width: geometry.size.width * 0.35, height: 40)
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                            }
                            .frame(maxWidth: .infinity)
                            .buttonStyle(.borderedProminent)
                            .tint(.black)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
