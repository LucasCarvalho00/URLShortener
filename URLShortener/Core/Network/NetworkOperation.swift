//
//  NetworkOperation.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import Foundation

final class NetworkOperation {

    // MARK: - Private Attributes
    
    private let mockData: Data?

    // MARK: - Setup

    init(
        mockData: Data? = nil
    ) {
        self.mockData = mockData
    }
    
    // MARK: - Private Functions

    private func executeNetwork<T: Decodable>(request: RequestProtocol) async throws -> T {

        // BaseURL
        guard
            let objectURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL"),
            let baseURL = objectURL as? String
        else {
            throw NetworkOperationError.noBaseURL
        }
        
        // Monta URL base + path
        let apiStringURL = baseURL + request.path
            
        // Monta URL final (incluindo query params para GET)
        guard let apiURL = getURL(apiStringURL: apiStringURL, request: request) else {
            throw NetworkOperationError.noURL
        }
                
        var urlRequest = URLRequest(url: apiURL)
    
        // Headers
        if request.method != .GET {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let headersRequest = request.headers {
            for (key,value) in headersRequest {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Body (para métodos com body)
        if request.method != .GET, let parameters = request.parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = jsonData
            } catch {
                throw NetworkOperationError.erroParameters
            }
        }
        
        urlRequest.httpMethod = request.method.rawValue
            
        // Chamada de rede com async/await
        let (data, _) = try await URLSession.shared.data(for: urlRequest)

        // Garante que há dados
        guard !data.isEmpty else {
            throw NetworkOperationError.noData
        }
            
        // Decodifica
        return try parseObject(jsonData: data)
    }
    
    private func executeMockNetwork<T: Decodable>(mockData: Data) throws -> T {
        try parseObject(jsonData: mockData)
    }
    
    private func parseObject<T: Decodable>(jsonData: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: jsonData)
            return decoded
        } catch {
            throw NetworkOperationError.erroParsable
        }
    }
}

// MARK: - Protocol

extension NetworkOperation: NetworkOperationProtocol {
    func execute<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        if let mockData {
            return try executeMockNetwork(mockData: mockData)
        } else {
            return try await executeNetwork(request: request)
        }
    }
}
