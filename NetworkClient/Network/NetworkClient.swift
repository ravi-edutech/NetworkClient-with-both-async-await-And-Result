//
//  NetworkClient.swift
//  InterviewProject
//
//  Created by Mr Ravi on 23/01/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case parsingError
}

protocol NetworkClientProtocol {
    func getData<T>(url:String, completion: @escaping (Result<T, NetworkError>) -> Void) where T:Decodable
    func fetch<T>(type:T.Type,url:URL) async throws -> T where T: Decodable
    
}

class NetworkClient: NetworkClientProtocol {
    var dataParser:DataParserProtocol
    var apiClient:APIClientProtocol
    init(apiClient: APIClientProtocol = APIClient(), dataParser:DataParserProtocol = DataParser()) {
        self.apiClient = apiClient
        self.dataParser = dataParser
    }
    
    func fetch<T>(type:T.Type,url:URL) async throws -> T where T: Decodable {
        
        do {
            let data = try await self.apiClient.fetch(url: url)
            let result = try await self.dataParser.parseData(type: type, data: data)
            return result
        }catch {
            throw error
        }
    }
    
    func getData<T>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        self.apiClient.fetch(url: url, completion: { result in
            
            switch result {
                case .success(let data):
                    
                    self.dataParser.parseData(data: data, completion: { (result:Result<T,NetworkError>) in
                        switch result{
                        case .success(let model):
                            completion(.success(model))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    })
                case .failure(let error):
                    completion(.failure(error))
            }
        })
    }
}
