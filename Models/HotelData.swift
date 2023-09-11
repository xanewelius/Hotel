//
//  HotelData.swift
//  Hotel
//
//  Created by Max Kuzmin on 11.09.2023.
//

import Foundation

struct Hotel: Decodable {
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel
}

struct AboutTheHotel: Decodable {
    let description: String
    let peculiarities: [String]
}
