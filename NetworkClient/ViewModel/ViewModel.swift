//
//  ViewModel.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    
    private let networkClient: NetworkClient
    init(networkClient:NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCategories() async {
        Task { @MainActor in
            do {
                let categoryArray = try await networkClient.fetch(type:[String].self, url: Endpoint.categories.url)
                categories = categoryArray.compactMap({ category in
                    Category(id: UUID(), name: category)
                })
            } catch {
                print(error)
            }
        }
    }
    
    func loadProducts(inCategory category: Category) async {
        Task { @MainActor in
            products = []
            do {
                products = try await networkClient.fetch(type:ProductsResponse.self, url:Endpoint.products(category: category).url).products
            } catch {
                print(error)
            }
        }
    }
}
