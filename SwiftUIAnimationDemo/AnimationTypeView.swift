//
//  AnimationTypeView.swift
//  SwiftUIAnimationDemo
//  
//  Created by Bai, Payne on 2023/4/9.
//  Copyright © 2023 Garmin All rights reserved
//  

import SwiftUI

struct AnimationTypeView: View {
    @State var startAnimation = false
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                ImplicitExample(startAnimation: $startAnimation)
                ExplicitExample(startAnimation: $startAnimation)
            }
            .padding(.horizontal, 20)
            Button {
                print("开始动画")
                startAnimation.toggle()
            } label: {
                Text("start animation")
            }
            Spacer()
        }
    }

    struct ImplicitExample: View {
        @State var isNormal: Bool = true
        @Binding var startAnimation: Bool
        var body: some View {
            VStack {
                Image("header")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(isNormal ? 1 : 0.6)
                    .animation(.default, value: isNormal)
                Text("implicit")
            }
            .onChange(of: startAnimation) { newValue in
                isNormal.toggle()
            }
        }
    }

    struct ExplicitExample: View {
        @State var isNormal: Bool = true
        @Binding var startAnimation: Bool
        var body: some View {
            VStack {
                Image("header")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(isNormal ? 1 : 0.6)
                Text("explicit")
            }
            .onChange(of: startAnimation) { newValue in
                withAnimation {
                    isNormal.toggle()
                }
            }
        }
    }
}

struct AnimationTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTypeView()
    }
}
