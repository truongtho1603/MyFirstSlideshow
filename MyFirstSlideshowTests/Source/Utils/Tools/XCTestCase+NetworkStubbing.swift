//
//  XCTestCase+NetworkStubbing.swift
//  DSKNetworkingTests
//
//  Created by Luan Bach on 03/10/2018.
//  Copyright © 2018 Touch Surgery. All rights reserved.
//

import Foundation
import XCTest
import Mockingjay
@testable import MyFirstSlideshow

extension XCTestCase {
    func stubImage(url: URL) {
        mockingjayRemoveStubOnTearDown = true
        let data = loadImageData(filename: "cat_test")

        MockingjayProtocol.addStub(matcher: uri(url.absoluteString), builder: http(download: Download.content(data)))
    }
}
