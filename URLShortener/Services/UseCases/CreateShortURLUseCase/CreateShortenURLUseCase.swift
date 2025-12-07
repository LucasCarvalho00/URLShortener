//
//  CreateShortenURLUseCase.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import Foundation

final class CreateShortenURLUseCase: CreateShortenURLUseCaseProtocol {

    // MARK: - Private Attributes

    private let network: NetworkOperationProtocol

    // MARK: - Initializers

    init(network: NetworkOperationProtocol = NetworkOperation()) {
        self.network = network
    }

    // MARK: - Internal Methods

    func execute(url: String) async throws -> CreateShortenURLResponse {
        let response: CreateShortenURLResponse = try await network.execute(
            ShortenerRequest.postShortenURL(url: url)
        )

        return response
    }
}
