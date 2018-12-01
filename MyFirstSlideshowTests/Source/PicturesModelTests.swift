//
//  PicturesModelTests.swift
//  MyFirstSlideshowTests
//
//  Created by Luan Bach on 27/11/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import XCTest
@testable import MyFirstSlideshow

class PicturesModelTests: XCTestCase {
    func testCreatePicturesModel() {
        let model = PicturesModel(picturePathStrings: imagesArray)
        
        XCTAssertEqual(model.count, 4)
        XCTAssertEqual(model.picturePathStrings, imagesArray)
    }
}
