//
//  InterviewProjectApp.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import SwiftUI

@main
struct InterviewProjectApp: App {
    var body: some Scene {
        WindowGroup {
            CategoriesView(viewModel: ViewModel(networkClient: NetworkClient()))
        }
    }
}
