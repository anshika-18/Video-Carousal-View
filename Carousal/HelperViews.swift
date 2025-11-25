//
//  SubViews.swift
//  Carousal
//
//  Created by Anshika Jain on 25/11/25.
//

import SwiftUI

struct SeparaterView: View {
    var body: some View {
        HStack(spacing: 15) {
            Rectangle()
                .fill(Color.black.opacity(0.2))
                .frame(height: 1)
            Text("or")
                .font(.system(size: 18, weight: .bold))
            Rectangle()
                .fill(Color.black.opacity(0.2))
                .frame(height: 1)
        }
        .padding(.horizontal, 30)
        .padding(.top, 10)
    }
}
