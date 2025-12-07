//
//  NetworkOperationMock.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

import Testing
@testable import URLShortener

final class NetworkOperationMock: NetworkOperationProtocol {
    
    var executeCalled = false
    var receivedRequest: RequestProtocol?
    
    var result: Any?
    var errorToThrow: Error?
    
    func execute<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        executeCalled = true
        receivedRequest = request
        
        // Se foi configurado um erro, lança
        if let errorToThrow {
            throw errorToThrow
        }
        
        // Retorna o resultado configurado, convertido para o tipo genérico T
        guard let result = result as? T else {
            fatalError("Configure `result` com o tipo esperado antes de chamar execute.")
        }
        
        return result
    }
}
