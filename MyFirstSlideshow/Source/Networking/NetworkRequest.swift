//
//  NetworkRequest.swift
//  MyFirstSlideshow
//
//  Created by Luan Bach on 28/11/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import UIKit

public enum RequestType: String {
    case GET, POST, PATCH
}

public struct NetworkRequest<T> {
    let method: RequestType
    let url: URL
    let parameters: [String: String]
    let parse: (Data) throws -> T
}

public extension NetworkRequest where T == UIImage {
    public init(method: RequestType, url: URL) {
        self.method = method
        self.url = url
        self.parameters = ["Accept": "image/*"]
        self.parse = { data in
            guard let model = UIImage(data: data) else {
                throw NetworkingError.failedParsing(type: String(describing: UIImage.self))
            }
            return model
        }
    }
}

public extension NetworkRequest {
    public func urlRequest() -> URLRequest {
        var request = URLRequest(url: self.url)

        request.httpMethod = method.rawValue

        request.allHTTPHeaderFields?.merge(self.parameters, uniquingKeysWith: { (current, _) -> String in
            return current
        })

        return request
    }
}
