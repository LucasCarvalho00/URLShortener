//
//  NetworkOperation+Extension.swift
//  URLShortener
//
//  Created by Lucas on 06/12/25.
//

import Foundation

extension NetworkOperation {
    func getURL(apiStringURL: String, request: RequestProtocol) -> URL? {
        switch request.method {
        case .GET:
            guard var components = URLComponents(string: apiStringURL) else {
                return nil
            }
            
            if let parameters = request.parameters {
                var queryItens: [URLQueryItem] = []
                for (key, value) in parameters {
                    queryItens.append(
                        URLQueryItem(
                            name: key,
                            value: value as? String
                        )
                    )
                }
                components.queryItems = queryItens
            }
            
            return components.url

        default:
            return URL(string: apiStringURL)
        }
    }
}
