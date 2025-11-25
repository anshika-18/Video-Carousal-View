//
//  MobileNumberView.swift
//  Carousal
//
//  Created by Anshika Jain on 25/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MobileNumberView: View {
    @State var mobile: String = ""

    var body: some View {
        HStack {
            HStack {
                WebImage(url: URL(string: "https://img.freepik.com/premium-photo/india-national-fabric-flag_113767-1933.jpg?semt=ais_hybrid&w=740&q=80"))
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("+91")
                    .font(.system(size: 20, weight: .heavy))
                WebImage(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5H95r00Iet-tXiKuZLIV8pB56d5ndHdwaJg&s"))
                    .resizable()
                    .frame(width: 12, height: 12)
            }
            TextField("Enter Mobile Number", text: $mobile)
                .padding(.leading, 5)
        }
        .padding(.all, 10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.black.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal, 30)
    }
}
