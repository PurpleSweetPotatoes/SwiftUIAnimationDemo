//
//  ContentView.swift
//  SwiftUIAnimationDemo
//  
//  Created by Bai, Payne on 2023/4/6.
//  Copyright © 2023 Garmin All rights reserved
//  

import SwiftUI

enum HomeListDataType: String, CaseIterable, Identifiable {
    case type = "AnimationTypeView"
    case normal = "NormalAnimationView"
    case animationCase = "AnimationCaseView"
    case matched = "MatchedAnimationView"
    case polygon = "PolygonAnimationView"
    case skewed = "SkewedOffsetView"
    case timeline = "TimeLineAnimationView"
    case hike = "HikeView"

    var id: String { rawValue }

    var displayView: AnyView {
        switch self {
        case .type:
            return AnyView(AnimationTypeView())
        case .normal:
            return AnyView(NormalAnimationView())
        case .animationCase:
            return AnyView(AnimationCaseView())
        case .polygon:
            return AnyView(PolygonAnimationView())
        case .matched:
            return AnyView(MatchedAnimationView())
        case .timeline:
            return AnyView(TimeLineAnimationView())
        case .skewed:
            return AnyView(SkewedOffsetView())
        case .hike:
            return AnyView(HikeView())
        }
    }

    var subTitle: String {
        switch self {
        case .type:
            return "The difference between explicit and implicit"
        case .normal:
            return "how use animation with a view"
        case .animationCase:
            return "the animation case test"
        case .polygon:
            return "how can animation work by custom"
        case .matched:
            return "how use animation between two view"
        case .timeline:
            return "how use keyFrame animation"
        case .skewed:
            return "custom animation view status"
        case .hike:
            return "apple animation tutorials"
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(HomeListDataType.allCases) { type in
                    NavigationLink(destination: type.displayView) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(type.rawValue)
                            Text(type.subTitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Animation Demo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
