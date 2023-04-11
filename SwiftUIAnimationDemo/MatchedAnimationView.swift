//
//  MatchedAnimationView.swift
//  SwiftUIAnimationDemo
//  
//  Created by Bai, Payne on 2023/4/6.
//  Copyright © 2023 Garmin All rights reserved
//  

import SwiftUI

struct MatchedAnimationView: View {
    @Environment(\.presentationMode) var presentationMode
    @Namespace var animationSpace
    let colors: [Color] = [.gray, .red, .blue, .orange, .green]
    @State var color: Color?
    var haveColor: Bool {
        color != nil
    }
    var body: some View {
        ZStack {
            VStack() {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 20, content: {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(minHeight: 100)
                            .matchedGeometryEffect(id: "color\(color)", in: animationSpace, properties: .frame)
                            .onTapGesture {
                                animationSetColor(color)
                            }
                    }
                })
                .padding(.horizontal, 10)
                Spacer()
            }
            .opacity(haveColor ? 0 : 1)
            .zIndex(0)

            if haveColor {
                VStack {
                    Group {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(color!)
                            .matchedGeometryEffect(id: "color\(color!)", in: animationSpace, properties: .frame)
                            .onTapGesture {
                                animationSetColor(nil)
                            }
                    }.frame(width: 200, height: 200)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    if haveColor {
                        animationSetColor(nil)
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Image(systemName: haveColor ? "xmark" : "chevron.backward")
                }
            }
        }
    }

    func animationSetColor(_ setColor: Color?) {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.1)) {
            color = setColor
        }
    }
}

struct MatchedAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedAnimationView()
    }
}
