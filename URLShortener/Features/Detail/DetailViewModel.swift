//
//  DetailViewModel.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI
import Combine

final class DetailViewModel: ObservableObject {
    
    // MARK: - Constants
    
    private enum Constants {
        static let genericShortenErrorMessage = "Não foi possível recuperar a URL encurtada."
    }
    
    // MARK: - Internal Attributes

    @Published var originalURL: String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = true

    // MARK: - Private Attributes

    private let recoverShortenURLUseCase: RecoverShortenURLUseCaseProtocol
    private let alias: String
    
    // MARK: - Initializers

    init(
        alias: String,
         recoverShortenURLUseCase: RecoverShortenURLUseCaseProtocol = RecoverShortenURLUseCase()
    ) {
        self.alias = alias
        self.recoverShortenURLUseCase = recoverShortenURLUseCase
    }
    
    // MARK: - Internal Functions

    func loadScreenData() async {
        await getShortenURL()
    }
    
    // MARK: - Private Functions

    private func getShortenURL() async {
        isLoading = true
        do {
            let response = try await recoverShortenURLUseCase.execute(alias: alias)
            errorMessage = ""
            isLoading = false
            originalURL = response.url
        } catch let error as NetworkOperationError {
            errorMessage = error.text
            isLoading = false
        } catch {
            errorMessage = Constants.genericShortenErrorMessage
            isLoading = false
        }
    }
}
