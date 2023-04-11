//
//  SkewedOffsetView.swift
//  MyTestDemo
//  
//  Created by Bai, Payne on 2023/4/3.
//  Copyright © 2023 Garmin All rights reserved
//  

// https://swiftui-lab.com/swiftui-animations-part1/

import SwiftUI

struct CustomSkewedOffset: GeometryEffect {
    enum MoveDirection {
        case left
        case right
    }

    var offset: CGFloat
    var pct: CGFloat
    var direction: MoveDirection

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(offset, pct)}
        set {
            offset = newValue.first
            pct = newValue.second
        }
    }

    init(offset: CGFloat, pct: CGFloat, direction: MoveDirection) {
        self.offset = offset
        self.pct = pct
        self.direction = direction
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        var skew: CGFloat
        if pct < 0.2 {
            skew = (pct * 5) * 0.5 * (direction == .right ? -1 : 1)
        } else if pct > 0.8 {
            skew = ((1 - pct) * 5) * 0.5 * (direction == .right ? -1 : 1)
        } else {
            skew = 0.5 * (direction == .right ? -1 : 1)
        }
        return ProjectionTransform(CGAffineTransform(1, 0, skew, 1, offset, 0))
    }
}

struct SkewedOffsetView: View {
    @State var move: Bool = false
    private let stringList = ["I'm SwiftUI", "I'm Swift", "I'm Object-C"]
    let animation = Animation.easeInOut(duration: 1.0)
    var skewedOffset: CustomSkewedOffset {
        CustomSkewedOffset(offset: move ? 120: -120, pct: move ? 1 : 0, direction: move ? .right : .left)
    }
    var body: some View {
        VStack(spacing: 10) {
            ForEach(stringList.indices, id: \.self) { index in
                Text(stringList[index])
                    .frame(width: 120)
                    .padding([.vertical], 10)
                    .background(Color.random)
                    .modifier(skewedOffset)
                    .animation(animation.delay(0.2 * Double(index)), value: move)
            }
            .padding(.top, 10)
            Text("Touch Labels")
            Spacer()
        }
        .onTapGesture {
            move.toggle()
        }
    }
}

struct SkewedOffsetView_Previews: PreviewProvider {
    static var previews: some View {
        SkewedOffsetView()
    }
}

extension Color {
    static var random: Color {
        let red = Double(Int.random(in: 0..<256)) / 255.0
        let green = Double(Int.random(in: 0..<256)) / 255.0
        let blue = Double(Int.random(in: 0..<256)) / 255.0
        return Color(red: red, green: green, blue: blue)
    }
}
