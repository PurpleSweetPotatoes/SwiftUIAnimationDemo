//
//  PolygonAnimationView.swift
//  SwiftUIAnimationDemo
//  
//  Created by Bai, Payne on 2023/4/7.
//  Copyright © 2023 Garmin All rights reserved
//  

import SwiftUI

struct PolygonShape: Shape {
    var sides: Double
    var animatableData: Double {
        get { return sides }
        set { sides = newValue }
    }

    func path(in rect: CGRect) -> Path {
        // hypotenuse
        let h = Double(min(rect.width, rect.height)) * 0.5
        // center
        let c = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        var path = Path()
        var vertex: [CGPoint] = []
        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0
        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180.0
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            if i == 0 {
                path.move(to: pt)
            } else {
                path.addLine(to: pt)
            }
            vertex.append(pt)
        }
        path.closeSubpath()

        drawVertexLines(path: &path, vertex: vertex, n: 0)
        print("current shape sides is: \(sides)")
        return path
    }

    private func drawVertexLines(path: inout Path, vertex: [CGPoint], n: Int) {
        if (vertex.count - n) < 3 { return }
        for i in (n+2)..<min(n + (vertex.count-1), vertex.count) {
            path.move(to: vertex[n])
            path.addLine(to: vertex[i])
        }
        drawVertexLines(path: &path, vertex: vertex, n: n+1)
    }
}

struct PolygonAnimationView: View {
    @State var processValue: CGFloat = 3
    var body: some View {
        VStack {
            Text("PolygonShape Animation")
                .padding(.bottom, 10)
            PolygonShape(sides: ceil(processValue))
                .stroke(Color.blue, lineWidth: 3)
                .animation(.easeInOut(duration: 1), value: processValue)
            Text("\(Int(ceil(processValue))) sides")
            Slider(value: $processValue, in: 2...20) {} minimumValueLabel: {
                Text("2")
            } maximumValueLabel: {
                Text("20")
            }
        }
        .padding(20)
    }
}

struct PolygonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        PolygonAnimationView()
    }
}
