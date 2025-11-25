//
//  CarousalViewModel.swift
//  Carousal
//
//  Created by Anshika Jain on 25/11/25.
//

import SwiftUI

class CarousalViewModel: ObservableObject {
    @Published var data: [String] = ["https://img.freepik.com/free-photo/new-york-city_649448-1679.jpg?semt=ais_hybrid&w=740&q=80", "https://burst.shopifycdn.com/photos/city-landscape-at-night.jpg?width=1000&format=pjpg&exif=0&iptc=0","https://t4.ftcdn.net/jpg/02/83/83/93/360_F_283839302_yt6JIsE96Pj4PydFDcBNKDUnuSpYB9h0.jpg", "https://images.pexels.com/photos/1563256/pexels-photo-1563256.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", "https://images.pexels.com/photos/169647/pexels-photo-169647.jpeg?cs=srgb&dl=pexels-peng-liu-45946-169647.jpg&fm=jpg"]
    
    @Published var logos: [String] = ["https://thumbs.dreamstime.com/b/google-logo-vector-format-white-background-illustration-407571048.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/625px-Apple_logo_black.svg.png", "https://thumbs.dreamstime.com/b/%D0%BF%D0%B5%D1%87%D0%B0%D1%82%D1%8C-201003176.jpg"]
}
