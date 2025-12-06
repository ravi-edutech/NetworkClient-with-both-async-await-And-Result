//
//  CategoryModel.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import Foundation

struct Category: Decodable, Identifiable {
    let slug: String
    let name: String
    let url: String
    var id: String { slug }
}
