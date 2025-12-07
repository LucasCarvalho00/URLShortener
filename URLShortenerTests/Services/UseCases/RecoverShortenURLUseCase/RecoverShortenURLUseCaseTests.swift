//
//  RecoverShortenURLUseCaseTests.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

/*
O que estes testes verificam:
- Se o use case chama o NetworkOperationProtocol.execute() quando execute(alias:) é invocado.
- Se o resultado retornado pela camada de rede é propagado corretamente pelo use case.
- Se um erro lançado pela camada de rede também é propagado pelo use case.
*/

import Testing
@testable import URLShortener

@MainActor
struct RecoverShortenURLUseCaseTests {
    
    // MARK: - Tests
    
    @Test
    func execute_callsNetworkAndReturnsResponse() async throws {
        // GIVEN
        let networkMock = NetworkOperationMock()
        
        let expectedResponse = RecoverShortenURLResponse(
            url: "https://meu-site-original.com"
        )
        
        networkMock.result = expectedResponse
        
        let sut = RecoverShortenURLUseCase(network: networkMock)
        let alias = "meu-alias"
        
        // WHEN
        let response = try await sut.execute(alias: alias)
        
        // THEN
        #expect(networkMock.executeCalled, "Era esperado que execute() do network fosse chamado.")
        #expect(networkMock.receivedRequest != nil, "Era esperado que uma RequestProtocol fosse passada ao network.")
        #expect(response.url == expectedResponse.url)
    }
    
    @Test
    func execute_propagatesNetworkError() async {
        // GIVEN
        let networkMock = NetworkOperationMock()
        
        enum DummyError: Error, Equatable {
            case networkFail
        }
        
        networkMock.errorToThrow = DummyError.networkFail
        
        let sut = RecoverShortenURLUseCase(network: networkMock)
        let alias = "meu-alias"
        
        // WHEN / THEN
        do {
            _ = try await sut.execute(alias: alias)
            Issue.record("Era esperado lançar erro, mas o método completou sem erro.")
        } catch let error as DummyError {
            #expect(error == .networkFail, "Era esperado que o erro da camada de rede fosse propagado.")
        } catch {
            Issue.record("Lançou um erro inesperado: \(error)")
        }
    }
}
