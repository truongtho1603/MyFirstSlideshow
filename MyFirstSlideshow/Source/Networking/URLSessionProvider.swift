//
//  URLSessionProvider.swift
//  MyFirstSlideshow
//
//  Created by Luan Bach on 28/11/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import Foundation

public class URLSessionProvider {
    public let session: URLSession
    public static let defaultInstance: URLSessionProvider = URLSessionProvider()

    private static let defaultMemoryCapacity = 8 * 1024 * 1024
    private static let defaultDiskCapacity = 40 * 1024 * 1024

    private static func getDefaultConfig() -> URLSessionConfiguration {
        let urlCache = URLCache(memoryCapacity: URLSessionProvider.defaultMemoryCapacity, diskCapacity: URLSessionProvider.defaultDiskCapacity, diskPath: nil)
        let config = URLSessionConfiguration.default
        config.urlCache = urlCache
        return config
    }

    init(config: URLSessionConfiguration? = nil) {
        if config == nil {
            session = URLSession(configuration: URLSessionProvider.getDefaultConfig())
        } else {
            session = URLSession(configuration: config!)
        }
    }
}
