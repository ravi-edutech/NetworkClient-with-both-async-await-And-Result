//
//  APIClient.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func fetch(url:URL, completion: @escaping (Result<Data,NetworkError>) -> Void)
    func fetch(url:URL) async throws -> Data
    func fetch<T>(type:T.Type,url:URL) -> Future<T,NetworkError> where T: Decodable
}

class APIClient: APIClientProtocol {
    
    var cancelable: Set<AnyCancellable> = Set()
    var cancelable1:AnyCancellable?
    var session: URLSession
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(url:URL) async throws -> Data {
        let (data, response) = try await self.session.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        return data
    }
    
    func fetch(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        self.session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }).resume()
    }
    
    func fetch<T>(type:T.Type,url:URL) -> Future<T,NetworkError> where T: Decodable {
        return Future<T,NetworkError> { promise in
            
            self.session.dataTaskPublisher(for: url)
                .tryMap({ (data, response) -> Data in
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw NetworkError.invalidResponse
                    }
                    return data
                })
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    print(completion)
                    switch completion {
                    case .failure(_):
                        promise(.failure(.parsingError))
                    case .finished:
                        break
                    }
                }, receiveValue: { model in
                    promise(.success(model))
                })
                .store(in: &self.cancelable)
        }
    }
}
