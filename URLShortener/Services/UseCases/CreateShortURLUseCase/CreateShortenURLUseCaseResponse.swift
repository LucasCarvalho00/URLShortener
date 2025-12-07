//
//  CreateShortenURLUseCaseResponse.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

struct CreateShortenURLResponse: Decodable {
    let alias: String
    let links: CreateShortenURLLink

    enum CodingKeys: String, CodingKey {
        case alias
        case links = "_links"
    }
}

struct CreateShortenURLLink: Decodable {
    let selfURL: String
    let short: String

    enum CodingKeys: String, CodingKey {
        case selfURL = "self"
        case short
    }
}
