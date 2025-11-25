//
//  ContentView.swift
//  Carousal
//
//  Created by Anshika Jain on 21/11/25.
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

struct ContentView: View {
    var body: some View {
        ScreenMainView()
    }
}

struct ScreenMainView: View {
    var viewModel: CarousalViewModel = .init()
    
    var body: some View {
        VStack {
            HeaderView()
            CarousalView(viewModel: viewModel)
                .padding(.top, 20)
            
            Text("Get Visas\nOn Time")
                .multilineTextAlignment(.center)
                .font(.system(size: 40, weight: .heavy))
            
            MobileNumberView()
            
            Button(action: {
                
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(width: UIScreen.main.bounds.width - 50, height: 55)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            SeparaterView()
            
            HStack(spacing: 35) {
                ForEach(0..<viewModel.logos.count, id: \.self) { index in
                    WebImage(url: URL(string: viewModel.logos[index]))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(.all, 10)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                }
            }
            .padding(.top, 10)
            
            Text("By continuing you agree to our terms & privacy policy")
                .multilineTextAlignment(.center)
                .font(.system(size: 15, weight: .semibold))
                .padding(.top, 10)
            Spacer()
        }
    }
}

struct HeaderView: View {
    var body: some View {
        WebImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/8/84/Atlys_logo_highres.png"))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 60)
        Text("Visas on time")
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(.purple)
    }
}


#Preview {
    ContentView()
}

struct CityCardView: View {
    let themeData: String?
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: themeData ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 250)
            VStack {
                Spacer()
                HStack {
                    VStack (alignment: .leading, spacing: 2){
                        Text("Malaysia")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.leading, 5)
                        Text("12+ Visas at Atlys")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.all, 5)
                            .background(.blue)
                        
                    }
                    .padding(.bottom, 30)
                    Spacer(minLength: 0)
                }
            }
        }
        .frame(width: 250, height: 250)
        .cornerRadius(12)
    }
}
