//
//  ContentView.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack{
            List(viewModel.categories) { category in
                NavigationLink(
                    category.name,
                    destination: ProductsView(category: category, viewModel: viewModel)
                )
            }.task {
                await viewModel.loadCategories()
            }
            .navigationTitle("Categories")
        } 
    }
}

#Preview {
    CategoriesView(viewModel: ViewModel(networkClient: NetworkClient()))
}
