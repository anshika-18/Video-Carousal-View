//
//  ContentView.swift
//  Carousal
//
//  Created by Anshika Jain on 21/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

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
                .font(.system(size: 35, weight: .heavy))
            
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
            .padding(.top, 5)
            
            Text("By continuing you agree to our terms & privacy policy")
                .multilineTextAlignment(.center)
                .font(.system(size: 13, weight: .semibold))
                .padding(.top, 5)
                .padding(.horizontal, 20)
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
