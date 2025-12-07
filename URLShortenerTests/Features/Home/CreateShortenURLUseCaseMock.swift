//
//  CreateShortenURLUseCaseMock.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

import Testing
@testable import URLShortener

final class CreateShortenURLUseCaseMock: CreateShortenURLUseCaseProtocol {
        
    enum DummyError: Error {
        case generic
    }
    
    var executeCalled = false
    var receivedURL: String?
    var result: Result<CreateShortenURLResponse, Error> = .failure(DummyError.generic)
    
    func execute(url: String) async throws -> CreateShortenURLResponse {
        executeCalled = true
        receivedURL = url
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
