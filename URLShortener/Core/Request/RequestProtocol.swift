//
//  RequestProtocol.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

protocol RequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}
