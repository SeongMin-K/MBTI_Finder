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
    @State var answerValue: Float = 0.0
    @State var questionIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color("PrimaryColor")
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
                                .tint(Color("SecondaryColor"))
                                .shadow(color: .primary, radius: 3, x: 1, y: 2)
                            Spacer(minLength: geometry.size.height * 0.15)
                            Text(questions.getQuestionText(at: questionIndex))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.system(size: 20, weight: .light, design: .rounded))
                                .padding()
                                .foregroundColor(.white)
                                .background(Color("SecondaryColor"))
                                .cornerRadius(15)
                            Spacer(minLength: geometry.size.height * 0.15)
                            Text(getAnswerText(value: answerValue))
                            Slider(value: $answerValue,
                                   in: -2...2,
                                   step: 1,
                                   minimumValueLabel: Text("No"),
                                   maximumValueLabel: Text("Yes"),
                                   label: { Text("Answer") })
                                .tint(Color("SecondaryColor"))
                            Spacer(minLength: geometry.size.height * 0.05)
                            HStack(spacing: 20) {
                                if (questions.questions.count > questionIndex) {
                                    Button {
                                        if questionIndex != 0 {
                                            questionIndex -= 1
                                            answerValue = score.answers[questionIndex]
                                            score.prevButtonAction()
                                            isCompleted = questions.questions.count <= questionIndex
                                        } 
                                    } label: {
                                        Text("이전")
                                            .frame(width: geometry.size.width * 0.35, height: 40)
                                            .font(.system(size: 18, weight: .medium, design: .rounded))
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .foregroundColor(.white)
                                    .tint(.black)
                                    Button {
                                        questionIndex += 1
                                        score.nextButtonAction(value: answerValue)
                                        answerValue = 0.0
                                        if (questions.questions.count <= questionIndex) {
                                            isCompleted = true
                                            score.resultProcess()
                                        }
                                    } label: {
                                        Text(questionIndex == questions.questions.count - 1 ? "완료" : "다음")
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
                                            score.resetProcess()
                                        } label: {
                                            Text("다시 검사하기")
                                                .frame(width: geometry.size.width * 0.85, height: 40)
                                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .foregroundColor(Color(UIColor.black))
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
        }.preferredColorScheme(.light)
    }
    
    func getAnswerText(value: Float) -> String {
        switch value {
        case -2.0:  return "매우 아니다"
        case -1.0:  return "조금 아니다"
        case 0.0:   return "보통이다"
        case 1.0:   return "조금 그렇다"
        case 2.0:   return "매우 그렇다"
        default:    return "Value Error"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
