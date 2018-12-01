//
//  NetworkingTests.swift
//  MyFirstSlideshowTests
//
//  Created by Luan Bach on 28/11/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import XCTest
import RxSwift

@testable import MyFirstSlideshow

class NetworkingTests: XCTestCase {
    private var baseURL: String!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        baseURL = "https://myslideshow.com/"
    }

    override func tearDown() {
        super.tearDown()
        disposeBag = nil
        baseURL = nil
    }

    func testLoadingImage() {
        let path = baseURL + "cat_test"
        let url = URL(fileURLWithPath: path)

        stubImage(url: url)

        let networkExpectation = self.expectation(description: "Download cat_test.jpg")

        let request = NetworkRequest<UIImage>(method: .GET, url: url)

        let networking = Networking()
        networking.get(request: request)
            .subscribe(onNext: { image in
                XCTAssertNotNil(image)
                networkExpectation.fulfill()
            }, onError: { error in
                XCTFail("Failed to download image: \(error)")
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 1, handler: nil)
    }
}
