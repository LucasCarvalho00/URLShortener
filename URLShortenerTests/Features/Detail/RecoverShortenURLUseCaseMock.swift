//
//  RecoverShortenURLUseCaseMock.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

import Testing
@testable import URLShortener

final class RecoverShortenURLUseCaseMock: RecoverShortenURLUseCaseProtocol {
    
    var executeCalled = false
    var receivedAlias: String?
    var result: Result<RecoverShortenURLResponse, Error> = .success(
        RecoverShortenURLResponse(url: "https://default.com")
    )
    
    func execute(alias: String) async throws -> RecoverShortenURLResponse {
        executeCalled = true
        receivedAlias = alias
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
