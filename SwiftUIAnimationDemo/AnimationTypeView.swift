//
//  AnimationTypeView.swift
//  SwiftUIAnimationDemo
//  
//  Created by Bai, Payne on 2023/4/9.
//  Copyright © 2023 Garmin All rights reserved
//  

import SwiftUI

struct AnimationTypeView: View {
    var body: some View {
        VStack(spacing: 20) {
            ImplicitExample()
                .frame(maxHeight: 200)
            ExplicitExample()
                .frame(maxHeight: 200)
        }
    }

    struct ImplicitExample: View {
        @State var isScale: Bool = true
        @State var needAlpha: Bool = true
        var body: some View {
            Image("header")
                .scaleEffect(isScale ? 1 : 0.6)
                .animation(.default, value: isScale)
                .opacity(needAlpha ? 1 : 0.6)
            Button {
                isScale.toggle()
                needAlpha.toggle()
            } label: {
                Text("implicit animation")
            }
        }
    }

    struct ExplicitExample: View {
        @State var isScale: Bool = true
        @State var needAlpha: Bool = true
        var body: some View {
            Image("header")
                .scaleEffect(isScale ? 1 : 0.6)
                .opacity(needAlpha ? 1 : 0.6)
            Button {
                withAnimation {
                    isScale.toggle()
                    needAlpha.toggle()
                }
            } label: {
                Text("explicit animation")
            }
        }
    }
}

struct AnimationTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTypeView()
    }
}
