//
//  NetworkOperationTests.swift
//  URLShortener
//
//  Created by Lucas on 07/12/25.
//

import Testing
import Foundation
@testable import URLShortener

/* 
 O que estes testes verificam:
 - Se o método execute() consegue decodificar corretamente um JSON válido recebido via mockData.
 - Se, ao receber dados inválidos, o método execute() lança o erro de parsing esperado (.erroParsable).
 - Se, quando mockData é informado, a chamada usa esses dados mockados em vez de tentar fazer uma requisição real de rede.
*/

@MainActor
struct NetworkOperationTests {
    
    // MARK: - Helpers
    
    /// Entidade simples pra decodificar no teste
    private struct DummyResponse: Decodable, Equatable {
        let value: String
    }
    
    /// Request “fake” só pro teste
    private struct DummyRequest: RequestProtocol {
        var path: String = "/dummy"
        var method: RequestMethod = .GET
        var headers: [String : String]? = nil
        var parameters: [String : Any]? = nil
    }
    
    // MARK: - Tests
    
    @Test
    func execute_withValidMockData_decodesSuccessfully() async throws {
        // GIVEN
        let json = """
        {
            "value": "ok"
        }
        """
        let mockData = Data(json.utf8)
        let sut = NetworkOperation(mockData: mockData)
        let request = DummyRequest()
        
        // WHEN
        let response: DummyResponse = try await sut.execute(request)
        
        // THEN
        #expect(response == DummyResponse(value: "ok"))
    }
    
    @Test
    func execute_withInvalidMockData_throwsErroParsable() async {
        // GIVEN
        let invalidJSON = Data("Not a JSON".utf8)
        let sut = NetworkOperation(mockData: invalidJSON)
        let request = DummyRequest()
        
        // WHEN / THEN
        do {
            let _: DummyResponse = try await sut.execute(request)
            Issue.record("Era esperado lançar erro, mas não lançou")
        } catch let error as NetworkOperationError {
            #expect(error == .erroParsable)
        } catch {
            Issue.record("Lançou um erro inesperado: \(error)")
        }
    }
    
    @Test
    func execute_usesMockDataInsteadOfNetwork() async throws {
        // GIVEN
        let json = """
        { "value": "fromMock" }
        """
        let mockData = Data(json.utf8)
        let sut = NetworkOperation(mockData: mockData)
        let request = DummyRequest()
        
        // WHEN
        let response: DummyResponse = try await sut.execute(request)
        
        // THEN
        #expect(response.value == "fromMock")
    }
}
