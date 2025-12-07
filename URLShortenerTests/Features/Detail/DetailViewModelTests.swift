//
//  DetailViewModelTests.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

/*
 O que estes testes verificam:
 - Estado inicial da view model (isLoading, originalURL, errorMessage).
 - Comportamento de loadScreenData() quando:
    - O use case retorna sucesso (preenche originalURL, limpa mensagem de erro, para o loading).
    - O use case lança um NetworkOperationError (usa o texto do erro e para o loading).
    - O use case lança um erro genérico (usa a mensagem genérica e para o loading).
 */

import Testing
@testable import URLShortener

@MainActor
struct DetailViewModelTests {
    
    // MARK: - Tests
    
    @Test
    func loadScreenData_whenUseCaseSucceeds_setsOriginalURLAndStopsLoading() async throws {
        // GIVEN
        let useCase = RecoverShortenURLUseCaseMock()
        useCase.result = .success(RecoverShortenURLResponse(url: "https://meu-site.com"))
        
        let sut = DetailViewModel(alias: "meu-alias", recoverShortenURLUseCase: useCase)
        
        // WHEN
        await sut.loadScreenData()
        // Dá tempo pro Task interno rodar
        try await Task.sleep(nanoseconds: 50_000_000) // 0.05s
        
        // THEN
        #expect(useCase.executeCalled)
        #expect(useCase.receivedAlias == "meu-alias")
        #expect(sut.originalURL == "https://meu-site.com")
        #expect(sut.errorMessage == "")
        #expect(sut.isLoading == false)
    }
    
    @Test
    func loadScreenData_whenUseCaseThrowsNetworkOperationError_setsErrorTextAndStopsLoading() async throws {
        // GIVEN
        let useCase = RecoverShortenURLUseCaseMock()
        useCase.result = .failure(NetworkOperationError.noData) // ajuste pro case que você quiser
        
        let sut = DetailViewModel(alias: "meu-alias", recoverShortenURLUseCase: useCase)
        
        // WHEN
        await sut.loadScreenData()
        try await Task.sleep(nanoseconds: 50_000_000)
        
        // THEN
        #expect(useCase.executeCalled)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == NetworkOperationError.noData.text)
        #expect(sut.originalURL == "")
    }
    
    @Test
    func loadScreenData_whenUseCaseThrowsGenericError_setsGenericMessageAndStopsLoading() async throws {
        // GIVEN
        let useCase = RecoverShortenURLUseCaseMock()
        
        enum DummyError: Error {
            case generic
        }
        
        useCase.result = .failure(DummyError.generic)
        
        let sut = DetailViewModel(alias: "meu-alias", recoverShortenURLUseCase: useCase)
        
        // WHEN
        await sut.loadScreenData()
        try await Task.sleep(nanoseconds: 50_000_000)
        
        // THEN
        #expect(useCase.executeCalled)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == "Não foi possível recuperar a URL encurtada.")
        #expect(sut.originalURL == "")
    }
}
