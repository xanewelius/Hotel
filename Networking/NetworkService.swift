//
//  NetworkService.swift
//  Hotel
//
//  Created by Max Kuzmin on 11.09.2023.
//

import Foundation

class NetworkService {
    private let endpoint = "https://run.mocky.io/v3/35e0d18e-2521-4f1b-a575-f0fe366f66e3"
    
    public func getHotel() async throws -> Hotel {
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Hotel.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknown
}
