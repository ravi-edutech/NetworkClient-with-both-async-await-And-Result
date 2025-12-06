//
//  NetworkClientApp.swift
//  NetworkClient
//
//  Created by Mr Ravi on 07/02/24.
//

import SwiftUI

@main
struct NetworkClientApp: App {
    var body: some Scene {
        WindowGroup {
            CategoriesView(viewModel: ViewModel(networkClient: NetworkClient()))
        }
    }
}
