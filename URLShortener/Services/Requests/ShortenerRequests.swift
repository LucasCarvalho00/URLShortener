//
//  ShortenerRequests.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import Foundation

enum ShortenerRequest: RequestProtocol {

    // MARK: - Cases

    case postShortenURL(url: String)
    case getShortenURL(alias: String)

    // MARK: - Properties

    var path: String {
        switch self {
        case .postShortenURL:
            return "/alias"
        case let .getShortenURL(alias):
            return "/alias/\(alias)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .postShortenURL:
            return .POST
        case .getShortenURL:
            return .GET
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case let .postShortenURL(url):
            return ["url": url]
        case .getShortenURL:
            return nil
        }
    }

    var headers: [String : String]? {
        switch self {
        case .postShortenURL:
            return nil
        case .getShortenURL:
            return nil
        }
    }

    var requestMock: String? {
        nil
    }
}
