//
//  NetworkOperationProtocol.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

protocol NetworkOperationProtocol {
    func execute<T: Decodable>(_ request: RequestProtocol) async throws -> T
}
