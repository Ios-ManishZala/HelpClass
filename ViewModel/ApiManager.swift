//
//  ApiManager.swift
//  SantaCallTracker
//
//  Created by DREAMWORLD on 06/09/23.
//

import Foundation
import UIKit


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add more HTTP methods as needed
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
    // Add more error cases as needed
}

class APIMANAGER  {
    
    static let shared = APIMANAGER()
    
    func performRequest<T: Decodable>(urlString: String, method: HTTPMethod, body: Data? = nil, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
