//
//  TimeLineAnimationView.swift
//  SwiftUIAnimationDemo
//  
//  Created by Bai, Payne on 2023/4/6.
//  Copyright © 2023 Garmin All rights reserved
//  

import SwiftUI

let Emoji = ["😀", "😬", "😄", "🙂", "😗", "🤓", "😏", "😕", "😟", "😎", "😜", "😍", "🤪"]

struct TimeLineAnimationView: View {
    @State var paused = true
    var body: some View {
        HStack {
//            VStack {
//                TimelineView(.animation(minimumInterval: 0.25, paused: false)) { timeline in
//                    VStack(spacing: 120) {
//                        EmojiImageView()
//                    }
//                }
//
//                Button {
//                    paused.toggle()
//                } label: {
//                    Text(paused ? "play": "paused")
//                }
//            }
            CustomCyclicTimeLineView()
        }
    }

    struct EmojiImageView: View {
        let randomEmoji = Emoji[Int.random(in: 0..<Emoji.count)]
        var body: some View {
            Text(randomEmoji)
                .font(.title)
                .scaleEffect(2.0)
                .padding(.bottom, 10)
        }
    }
}

struct CyclicTimeLineSchedule: TimelineSchedule {
    struct Entries: Sequence, IteratorProtocol {
        var last: Date
        let offsets: [TimeInterval]
        var idx: Int = -1
        mutating func next() -> Date? {
            idx = (idx + 1) % offsets.count
            last = last.addingTimeInterval(offsets[idx])
            return last
        }
    }
    let timeOffsets: [TimeInterval]

    func entries(from startDate: Date, mode: Mode) -> Entries {
        Entries(last: startDate, offsets: timeOffsets)
    }
}

extension TimelineSchedule where Self == CyclicTimeLineSchedule {
    static func cyclic(timeOffset: [TimeInterval]) -> CyclicTimeLineSchedule {
        .init(timeOffsets: timeOffset)
    }
}

struct CustomCyclicTimeLineView: View {
    var body: some View {
        JumpingEmoji()
    }

    struct Heart: View {
        let date: Date
        @State var index: Int = 0
        let scales: [CGFloat] = [1.0, 1.6, 2.0]
        var body: some View {
            VStack {
                Text("❤️")
                    .font(.largeTitle)
                    .scaleEffect(scales[index])
                    .animation(.spring(response: 0.1, dampingFraction: 0.24, blendDuration: 0.2), value: index)
                    .padding([.bottom], 10)
                Text("\(index)")
            }
            .onChange(of: date) { _ in
                index = (index + 1) % scales.count
            }
        }
    }

    struct KeyFrame {
        let offset: TimeInterval
        let rotation: Double
        let yScale: Double
        let y: CGFloat
        let animation: Animation?

        static let keyframes = [
            // 初始状态
            KeyFrame(offset: 0.0, rotation: 0, yScale: 1.0, y: 0, animation: nil),
            // 动画关键帧
            KeyFrame(offset: 0.2, rotation:   0, yScale: 0.5, y:  20, animation: .linear(duration: 0.2)),
            KeyFrame(offset: 0.4, rotation:   0, yScale: 1.0, y: -20, animation: .linear(duration: 0.4)),
            KeyFrame(offset: 0.5, rotation: 360, yScale: 1.0, y: -80, animation: .easeOut(duration: 0.5)),
            KeyFrame(offset: 0.4, rotation: 360, yScale: 1.0, y: -20, animation: .easeIn(duration: 0.4)),
            KeyFrame(offset: 0.2, rotation: 360, yScale: 0.75, y:  20, animation: .easeOut(duration: 0.2)),
            KeyFrame(offset: 0.4, rotation: 360, yScale: 1.0, y: -20, animation: .linear(duration: 0.4)),
            KeyFrame(offset: 0.5, rotation:   0, yScale: 1.0, y: -80, animation: .easeOut(duration: 0.5)),
            KeyFrame(offset: 0.4, rotation:   0, yScale: 1.0, y: -20, animation: .easeIn(duration: 0.4))
        ]
    }

    struct JumpingEmoji: View {
        let offsets = Array(KeyFrame.keyframes.map { $0.offset }.dropFirst())

        var body: some View {
            TimelineView(.cyclic(timeOffset: offsets)) { timeline in
                HappyEmoji(date: timeline.date)
            }
        }

        struct HappyEmoji: View {
            @State var idx: Int = 0
            let date: Date
            var body: some View {
                Text("😃")
                    .font(.largeTitle)
                    .scaleEffect(4.0)
                    .modifier(Effects(keyframe: KeyFrame.keyframes[idx]))
                    .animation(KeyFrame.keyframes[idx].animation, value: idx)
                    .onChange(of: date) { _ in advanceKeyFrame() }
                    .onAppear { advanceKeyFrame()}
            }

            func advanceKeyFrame() {
                // 推进到下一个关键字
                idx = (idx + 1) % KeyFrame.keyframes.count

                // 跳过第一帧，它只用于初始状态
                if idx == 0 { idx = 1 }
            }

            struct Effects: ViewModifier {
                let keyframe: KeyFrame

                func body(content: Content) -> some View {
                    content
                        .scaleEffect(CGSize(width: 1.0, height: keyframe.yScale))
                        .rotationEffect(Angle(degrees: keyframe.rotation))
                        .offset(y: keyframe.y)
                }
            }
        }
    }
}

struct TimeLineAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineAnimationView()
    }
}
