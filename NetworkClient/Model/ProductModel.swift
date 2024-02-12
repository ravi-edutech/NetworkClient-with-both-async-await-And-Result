//
//  ProductModel.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import Foundation

struct Product: Identifiable, Decodable {
    let id: Int
    let title: String
    let price: Double
    let rating: Double
    let thumbnail: URL
    let images: [URL]
}

struct ProductsResponse: Decodable {
    let products: [Product]
}
