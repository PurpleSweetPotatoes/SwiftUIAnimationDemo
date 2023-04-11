//
//  NormalAnimationView.swift
//  SwiftUIAnimationDemo
//  
//  Created by Bai, Payne on 2023/4/6.
//  Copyright © 2023 Garmin All rights reserved
//  

import SwiftUI

struct NormalAnimationView: View {
    @State var rotateChanged: Bool = false
    @State var colorChanged: Bool = false
    @State var scaleChanged: Bool = false
    @State var offsetChanged: Bool = false
    var body: some View {
        VStack {
            Text( "I can do Animation")
                .foregroundColor(.white)
                .padding(20)
                .background(colorChanged ? Color.blue : Color.green)
                .animation(.easeInOut(duration: 0.5), value: colorChanged)
                .rotationEffect(.degrees(rotateChanged ? 180 : 0))
                .animation(.easeInOut(duration: 0.25), value: rotateChanged)
                .scaleEffect(scaleChanged ? 2 : 1)
                .animation(.easeInOut(duration: 0.25), value: scaleChanged)
                .offset(x: offsetChanged ? 120 : -120)
                .animation(.easeInOut(duration: 1), value: offsetChanged)
                .padding(.bottom, 20)
            Button {
                scaleChanged.toggle()
                rotateChanged.toggle()
                colorChanged.toggle()
                withAnimation {
                    offsetChanged.toggle()
                }
            } label: {
                Text("start animation")
            }
        }
    }
}

struct NormalAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        NormalAnimationView()
    }
}
