//
//  XCTestCase+JSON.swift
//  DSKNetworkingTests
//
//  Created by Luan Bach on 03/10/2018.
//  Copyright © 2018 Touch Surgery. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    func loadImageData(filename: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: "jpg") else {
            fatalError("Could not find jpg in bundle for \(filename).json")
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError("Could not load data from bundle for \(filename).json")
        }
    }
}
