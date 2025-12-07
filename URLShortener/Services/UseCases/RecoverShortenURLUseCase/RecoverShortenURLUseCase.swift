//
//  RecoverShortenURLUseCase.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import Foundation

final class RecoverShortenURLUseCase: RecoverShortenURLUseCaseProtocol {

    // MARK: - Private Attributes

    private let network: NetworkOperationProtocol

    // MARK: - Initializers

    init(network: NetworkOperationProtocol = NetworkOperation()) {
        self.network = network
    }

    // MARK: - Internal Methods

    func execute(alias: String) async throws -> RecoverShortenURLResponse {
        let response: RecoverShortenURLResponse = try await network.execute(
            ShortenerRequest.getShortenURL(alias: alias)
        )

        return response
    }
}
