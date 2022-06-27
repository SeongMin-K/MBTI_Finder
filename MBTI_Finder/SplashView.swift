//
//  SplashView.swift
//  MBTI_Finder
//
//  Created by SeongMinK on 2022/06/28.
//

import Lottie
import SwiftUI
import UIKit

struct SplashView : UIViewRepresentable {
    typealias UIViewType = UIView
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<SplashView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        
        animationView.animation = Animation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SplashView>) {
    }
}
