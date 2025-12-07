//
//  HomeViewModel.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    
    // MARK: - Constants
    
    private enum Constants {
        static let emptyURLErrorMessage = "Digite uma URL antes de encurtar."
        static let invalidURLErrorMessage = "URL inválida. Use algo como https://sou.nu"
        static let genericShortenErrorMessage = "Não foi possível encurtar essa URL."
        static let duplicatedItemErrorMessage = "Esse link encurtado já está na sua lista."
    }
    
    // MARK: - Internal Attributes

    @Published var inputText: String = ""
    @Published var errorMessage: String?
    @Published var items: [HomeListItem] = []
    @Published var isLoading: Bool = false

    // MARK: - Private Attributes

    private let createShortenURLUseCase: CreateShortenURLUseCaseProtocol

    // MARK: - Initializers

    init(createShortenURLUseCase: CreateShortenURLUseCaseProtocol = CreateShortenURLUseCase()) {
        self.createShortenURLUseCase = createShortenURLUseCase
    }
    
    // MARK: - Internal Functions

    func didTapAddButton() {
        Task {
            await startAsyncVerification()
        }
    }
    
    func startAsyncVerification() async {
        guard validateInputURL() else { return }
        await postInputURL()
    }
    
    func validateInputURL() -> Bool {
        let url = inputText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !url.isEmpty else {
            errorMessage = Constants.emptyURLErrorMessage
            return false
        }

        guard isValidURL(url) else {
            errorMessage = Constants.invalidURLErrorMessage
            return false
        }

        return true
    }
    
    func isValidURL(_ string: String) -> Bool {
        let trimmedURL = string.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let url = URL(string: trimmedURL) else {
            return false
        }

        guard let scheme = url.scheme?.lowercased(),
              scheme == "http" || scheme == "https" else {
            return false
        }

        return url.host != nil
    }
    
    // MARK: - Private Functions

    private func postInputURL() async {
        isLoading = true
        do {
            let response = try await createShortenURLUseCase.execute(url: inputText)
            let item = HomeListItem(
                title: response.alias,
                subTitle: response.links.short
            )
            
            checkItem(item: item)
        } catch let error as NetworkOperationError {
            errorMessage = error.text
            isLoading = false
        } catch {
            errorMessage = Constants.genericShortenErrorMessage
            isLoading = false
        }
    }
    
    private func checkItem(item: HomeListItem) {
        if items.contains(where: { $0.title == item.title }) {
            errorMessage = Constants.duplicatedItemErrorMessage
            isLoading = false
            return
        }
        
        items.insert(item, at: 0)
        inputText = ""
        isLoading = false
    }
}
