//
//  NetworkOperationError.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

enum NetworkOperationError: Error {
    
    // MARK: - Case

    case noData
    case erroParsable
    case noBaseURL
    case noURL
    case erroParameters

    // MARK: - Properties

    var text: String {
        switch self {
        case .noData:
            return "Nenhuma informação recebida da API"
        case .erroParsable:
            return "Error ao converter o JSON para Objeto"
        case .noBaseURL:
            return "Nenhuma URL encontrada"
        case .noURL:
            return "Error na construção da URL"
        case .erroParameters:
            return "Error nos parametros enviados para a requisição"
        }
    }
    
    var errorCode: Int {
        switch self {
        case .noData:
            return 01
        case .erroParsable:
            return 02
        case .noBaseURL:
            return 03
        case .noURL:
            return 04
        case .erroParameters:
            return 05
        }
    }
}
