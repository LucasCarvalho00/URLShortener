//
//  CreateShortenURLUseCaseTests.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

/*
 O que estes testes verificam:
 - Se o use case chama NetworkOperationProtocol.execute() e retorna o response correto.
 - Se um erro lançado pela camada de rede é propagado pelo use case.
*/

import Testing
@testable import URLShortener

@MainActor
struct CreateShortenURLUseCaseTests {
    
    // MARK: - Tests
    
    @Test
    func execute_callsNetworkAndReturnsResponse() async throws {
        // GIVEN
        let networkMock = NetworkOperationMock()
        
        let links = CreateShortenURLLink(
            selfURL: "https://sou.nu",
            short: "https://linkencurtado.com.br/31231231"
        )
        
        let expectedResponse = CreateShortenURLResponse(
            alias: "31231231",
            links: links
        )
        
        networkMock.result = expectedResponse
        
        let sut = CreateShortenURLUseCase(network: networkMock)
        let url = "https://meu-site.com"
        
        // WHEN
        let response = try await sut.execute(url: url)
        
        // THEN
        #expect(networkMock.executeCalled, "Era esperado que execute() do network fosse chamado.")
        #expect(networkMock.receivedRequest != nil, "Era esperado que uma RequestProtocol fosse passada ao network.")
        
        #expect(response.alias == expectedResponse.alias)
        #expect(response.links.selfURL == expectedResponse.links.selfURL)
        #expect(response.links.short == expectedResponse.links.short)
    }
    
    @Test
    func execute_propagatesNetworkError() async {
        // GIVEN
        let networkMock = NetworkOperationMock()
        
        enum DummyError: Error, Equatable {
            case networkFail
        }
        
        networkMock.errorToThrow = DummyError.networkFail
        
        let sut = CreateShortenURLUseCase(network: networkMock)
        let url = "https://meu-site.com"
        
        // WHEN / THEN
        do {
            _ = try await sut.execute(url: url)
            Issue.record("Era esperado lançar erro, mas o método completou sem erro.")
        } catch let error as DummyError {
            #expect(error == .networkFail, "Era esperado que o erro da camada de rede fosse propagado.")
        } catch {
            Issue.record("Lançou um erro inesperado: \(error)")
        }
    }
}
