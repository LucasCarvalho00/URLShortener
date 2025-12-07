//
//  CreateShortenURLUseCaseProtocol.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import Foundation

protocol CreateShortenURLUseCaseProtocol {
    func execute(url: String) async throws -> CreateShortenURLResponse
}
