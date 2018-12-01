//
//  Networking.swift
//  MyFirstSlideshow
//
//  Created by Luan Bach on 28/11/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import Foundation

public enum NetworkingError: Error {
    case undefined
    case timeout
    case noConnectivity
    case noContent
    case failedParsing(type: String)
    case failedCreatingNetworkRequest(type: String)
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .undefined:
            return "Undefined"
        case .timeout:
            return "Timeout"
        case .noConnectivity:
            return "No network connection"
        case .noContent:
            return "No content returned in network response"
        case .failedParsing(let type):
            return "Error on parsing of content: \(type)"
        case .failedCreatingNetworkRequest(let type):
            return "Failed to ceate a NetworkRequest object: \(type)"
        }
    }
}

public class Networking {
    private let session: URLSession

    public init(session: URLSession = URLSessionProvider.defaultInstance.session) {
        self.session = session
    }

//    public func get<T>(request: NetworkRequest<T>) -> Observable<T> {
//        let urlRequest = request.urlRequest()
//
//        return Observable<T>.create { [unowned self] observer in
//            let task = self.session.dataTask(with: urlRequest) { (data, _, error) in
//                if let error = error { observer.onError(error) }
//                guard let data = data else {
//                    observer.onError(NetworkingError.noContent)
//                    return
//                }
//                do {
//                    let model: T = try request.parse(data)
//                    observer.onNext(model)
//                    observer.onCompleted()
//                } catch let error {
//                    observer.onError(error)
//                }
//            }
//            task.resume()
//
//            return Disposables.create {
//                task.cancel()
//            }
//        }
//    }
}
