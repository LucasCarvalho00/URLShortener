//
//  RecoverShortenURLUseCaseProtocol.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import Foundation

protocol RecoverShortenURLUseCaseProtocol {
    func execute(alias: String) async throws -> RecoverShortenURLResponse
}
