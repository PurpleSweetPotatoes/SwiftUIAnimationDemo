//
//  AnimationCaseView.swift
//  SwiftUIAnimationDemo
//  
//  Created by Bai, Payne on 2023/4/16.
//  Copyright © 2023 Garmin All rights reserved
//  

import SwiftUI

struct AnimationCaseView: View {
    let animations: [Animation] = [.easeIn, .easeOut, .easeInOut, .linear]
    @State var isLeft = true
    var body: some View {
        VStack {
            ForEach(0..<animations.count, id: \.self) { index in
                VStack {
                    Text(animations[index].title)
                        .foregroundColor(.black)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.green)
                        .frame(width: 44, height: 44)
                        .offset(x: isLeft ? -100 : 100)
                        .animation(animations[index], value: isLeft)
                }
            }
            Button {
                isLeft.toggle()
            } label: {
                Text("start animation")
            }
            Spacer()
        }
    }
}

extension Animation {
    var title: String {
        switch self {
        case .easeIn:
            return "easeIn"
        case .easeOut:
            return "easeOut"
        case .easeInOut:
            return "easeInOut"
        case .linear:
            return "linear"
        default:
            return ""
        }
    }
}

struct AnimationCaseView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationCaseView()
    }
}
