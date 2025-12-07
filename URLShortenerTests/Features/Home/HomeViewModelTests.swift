//
//  HomeViewModelTests.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

/*
O que estes testes verificam:
- Validação do campo de URL (vazio, inválido e válido).
- Comportamento do didTapAddButton() quando:
   - A URL é inválida (não chama o use case).
   - A URL é válida e o use case retorna sucesso (adiciona item, limpa input, para loading).
   - O use case lança erro genérico (exibe mensagem genérica de erro e para loading).
   - A URL encurtada já está na lista (não duplica item e mostra mensagem de duplicidade).
*/

import Testing
@testable import URLShortener

@MainActor
struct HomeViewModelTests {
    
    // MARK: - didTapAddButton / fluxo assíncrono
    
    @Test
    func didTapAddButton_withInvalidURL_doesNotCallUseCase() async {
        // GIVEN
        let useCase = CreateShortenURLUseCaseMock()
        let sut = HomeViewModel(createShortenURLUseCase: useCase)
        sut.inputText = "sou.nu" // inválida
        
        // WHEN
        await sut.startAsyncVerification()
        
        // THEN
        #expect(useCase.executeCalled == false)
        #expect(sut.errorMessage == "URL inválida. Use algo como https://sou.nu")
    }
    
    @Test
    func didTapAddButton_withValidURL_andUseCaseSuccess_addsItemAndClearsInput() async throws {
        // GIVEN
        let useCase = CreateShortenURLUseCaseMock()
        
        let response = CreateShortenURLResponse(
            alias: "meu-alias",
            links: CreateShortenURLLink(
                selfURL: "https://api.sou.nu/links/xyz",
                short: "https://sho.rt/xyz"
            )
        )
        useCase.result = .success(response)
        
        let sut = HomeViewModel(createShortenURLUseCase: useCase)
        sut.inputText = "https://sou.nu"
        
        // WHEN
        sut.didTapAddButton()
        // dá tempo do Task interno rodar
        try await Task.sleep(nanoseconds: 50_000_000) // 0.05s
        
        // THEN
        #expect(useCase.executeCalled)
        #expect(useCase.receivedURL == "https://sou.nu")
        #expect(sut.items.count == 1)
        #expect(sut.items.first?.title == "meu-alias")
        #expect(sut.items.first?.subTitle == "https://sho.rt/xyz")
        #expect(sut.inputText == "")
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
    }
    
    @Test
    func didTapAddButton_whenUseCaseThrowsGenericError_setsGenericErrorMessageAndStopsLoading() async throws {
        // GIVEN
        let useCase = CreateShortenURLUseCaseMock()
        useCase.result = .failure(CreateShortenURLUseCaseMock.DummyError.generic)
        
        let sut = HomeViewModel(createShortenURLUseCase: useCase)
        sut.inputText = "https://sou.nu"
        
        // WHEN
        sut.didTapAddButton()
        try await Task.sleep(nanoseconds: 50_000_000)
        
        // THEN
        #expect(useCase.executeCalled)
        #expect(sut.errorMessage == "Não foi possível encurtar essa URL.")
        #expect(sut.isLoading == false)
        #expect(sut.items.isEmpty)
    }
    
    @Test
    func didTapAddButton_whenAliasAlreadyExists_setsDuplicatedErrorAndDoesNotInsertNewItem() async throws {
        // GIVEN
        let useCase = CreateShortenURLUseCaseMock()
        
        let response = CreateShortenURLResponse(
            alias: "meu-alias",
            links: CreateShortenURLLink(
                selfURL: "https://api.sou.nu/links/xyz",
                short: "https://sho.rt/xyz"
            )
        )
        useCase.result = .success(response)
        
        let sut = HomeViewModel(createShortenURLUseCase: useCase)
        sut.items = [
            HomeListItem(title: "meu-alias", subTitle: "https://sho.rt/abc")
        ]
        sut.inputText = "https://sou.nu"
        
        // WHEN
        sut.didTapAddButton()
        try await Task.sleep(nanoseconds: 50_000_000)
        
        // THEN
        #expect(sut.items.count == 1, "Não deve duplicar o item existente.")
        #expect(sut.errorMessage == "Esse link encurtado já está na sua lista.")
        #expect(sut.isLoading == false)
    }
}
