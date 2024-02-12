//
//  DataParser.swift
//  InterviewProject
//
//  Created by Mr Ravi on 07/02/24.
//

import Foundation

protocol DataParserProtocol {
    func parseData<T>(data:Data, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable
    func parseData<T>(type:T.Type, data:Data) async throws -> T where T: Decodable
}

class DataParser: DataParserProtocol {
    
    func parseData<T>(type:T.Type, data:Data) async throws -> T where T: Decodable {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        }catch {
            throw NetworkError.parsingError
        }
    }
    
    func parseData<T>(data: Data, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        }catch {
            completion(.failure(.parsingError))
        }
    }
}
