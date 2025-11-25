//
//  CarousalView.swift
//  Carousal
//
//  Created by Anshika Jain on 25/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CarousalView: View {
    @ObservedObject var viewModel: CarousalViewModel
    @State var currentIndex: Int = 0
    @State private var dragProgress: CGFloat = 0   // 0–1 progress between cards
    @GestureState private var gestureX: CGFloat = 0
    
    private var liveIndex: CGFloat {
        CGFloat(currentIndex) - dragProgress
    }
    
    private var overlap: CGFloat {
        let t = min(abs(dragProgress), 1)
        let peak = 1 - abs(t - 0.5) * 2
        return 150 + (225 - 150) * peak
    }
    
    var totalCards: Int {
        return viewModel.data.count
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                ZStack {
                    ForEach(0..<totalCards, id: \.self) { index in
                        let distance = abs(liveIndex - CGFloat(index))
                        
                        CityCardView(themeData: viewModel.data[index])
                            .scaleEffect(1 - distance * 0.2)
                            .offset(
                                x: (CGFloat(index) - liveIndex) * overlap,
                                y: 0)
                            .zIndex(Double(100 - distance * 10))
                    }
                }
                .gesture(
                    DragGesture()
                        .updating($gestureX) { value, state, _ in
                            state = value.translation.width
                            dragProgress = gestureX / 250
                        }
                        .onEnded { value in
                            onDragEnd(progress: -value.translation.width / 250)
                        }
                    
                )
                DailyCheckPageControl(viewModel: viewModel, currentIndex: $currentIndex)
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(height: 280)
    }
    
    private func onDragEnd(progress: CGFloat) {
        if progress > 0.3 {
            withAnimation(.spring()) {
                currentIndex = min(currentIndex + 1, totalCards - 1)
            }
        } else if progress < -0.3 {
            withAnimation(.spring()) {
                currentIndex = max(currentIndex - 1, 0)
            }
        }
        withAnimation(.easeOut(duration: 0.1)) {
            dragProgress = 0
        }
    }
}

struct DailyCheckPageControl: View {
    @ObservedObject var viewModel: CarousalViewModel
    @Binding var currentIndex: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 10.0) {
            HStack(spacing: 6) {
                ForEach(0..<viewModel.data.count, id: \.self) { index in
                    let width: CGFloat = currentIndex == index ? 8.0 : 6.0
                    let color: Color = currentIndex == index ? .gray : .gray.opacity(0.4)
                    Circle()
                        .fill(color)
                        .frame(width: width, height: width)
                }
            }
            .frame(height: 12)
        }
        .padding(.bottom, 10 * UIScreen.main.bounds.height / 812.0)
    }
}
