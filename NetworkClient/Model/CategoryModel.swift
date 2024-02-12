//
//  CategoryModel.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import Foundation

struct Category: Decodable, Identifiable {
    var id: UUID
    let name: String
}
