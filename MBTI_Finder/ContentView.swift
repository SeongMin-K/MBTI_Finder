//
//  ContentView.swift
//  MBTI_Finder
//
//  Created by 김성민 on 2022/03/25.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    @State var isCompleted: Bool = false
    @ObservedObject var questions = Questions()
    @ObservedObject var score = Score()
    @State var questionIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color(UIColor(red: 0.10, green: 0.74, blue: 0.61, alpha: 1.00))
                        .edgesIgnoringSafeArea(.all)
                    if isLoading {
                        SplashView(filename: "find-something")
                    } else {
                        VStack {
                            Text("\(questionIndex) / \(questions.questions.count) 문항")
                                .font(.system(size: 14, weight: .light, design: .rounded))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            ProgressView(value: questions.getProgress(at: questionIndex))
                                .progressViewStyle(.linear)
                                .tint(.secondary)
                                .shadow(color: .primary, radius: 3, x: 1, y: 2)
                            Spacer(minLength: geometry.size.height * 0.2)
                            Text(questions.getQuestionText(at: questionIndex))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.system(size: 20, weight: .light, design: .rounded))
                                .padding()
                                .foregroundColor(.white)
                                .background(.secondary)
                                .cornerRadius(15)
                            Spacer(minLength: geometry.size.height * 0.2)
                            HStack(spacing: 20) {
                                if ((questions.questions.count > questionIndex) ){
                                    Button {
                                        score.yesButtonAction(questionIndex)
                                        questionIndex += 1
                                        isCompleted = questions.questions.count <= questionIndex
                                    } label: {
                                        Text("그렇다")
                                            .frame(width: geometry.size.width * 0.35, height: 40)
                                            .font(.system(size: 18, weight: .medium, design: .rounded))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .foregroundColor(.white)
                                    .tint(.black)
                                    Button {
                                        score.noButtonAction(questionIndex)
                                        questionIndex += 1
                                        isCompleted = questions.questions.count <= questionIndex
                                    } label: {
                                        Text("아니다")
                                            .frame(width: geometry.size.width * 0.35, height: 40)
                                            .font(.system(size: 18, weight: .medium, design: .rounded))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .foregroundColor(.white)
                                    .tint(.black)
                                } else {
                                    VStack() {
                                        Text(score.getResult())
                                            .font(.system(size: 65, weight: .heavy, design: .monospaced))
                                            .foregroundColor(.white)
                                        Text(score.getNickname(score.getResult()))
                                            .font(.system(size: 25, weight: .medium, design: .monospaced))
                                            .foregroundColor(.white)
                                        Spacer(minLength: 50)
                                        Button {
                                            questionIndex = 0
                                            score.resetScores()
                                        } label: {
                                            Text("다시 검사하기")
                                                .frame(width: geometry.size.width * 0.85, height: 40)
                                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .foregroundColor(.black)
                                        .tint(.white)
                                    }
                                }
                            }
                            Spacer(minLength: geometry.size.height * 0.1)
                        }
                        .padding()
                        .navigationBarTitle("MBTI Finder")
                    }
                    if isCompleted {
                        Color(UIColor(red: 0.10, green: 0.74, blue: 0.61, alpha: 1.00))
                            .edgesIgnoringSafeArea(.all)
                        SplashView(filename: "find-something")
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                                    withAnimation { isCompleted.toggle() }
                                })
                            }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        withAnimation { isLoading.toggle() }
                    })
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
