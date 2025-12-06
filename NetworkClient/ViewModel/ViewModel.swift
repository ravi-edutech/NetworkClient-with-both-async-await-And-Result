//
//  ViewModel.swift
//  NetworkClient
//
//  Created by Mr Ravi on 07/02/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    
    private let networkClient: NetworkClientProtocol
    init(networkClient:NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func loadCategories() async {
        Task { @MainActor in
            do {
                categories = try await networkClient.fetch(type:[Category].self, url: Endpoint.categories.url)
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
