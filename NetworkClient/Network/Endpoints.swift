//
//  Endpoints.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import Foundation

enum Endpoint {
    case categories
    case products(category: Category)
    
    var url: URL {
        switch self {
        case .categories:
            return URL(string: "https://dummyjson.com/products/categories")!
        case .products(let category):
            return URL(string: "https://dummyjson.com/products/category/\(category.name)")!
        }
    }
}
