//
//  SlideShowViewModelTests.swift
//  MyFirstSlideshowTests
//
//  Created by Luan Bach on 28/11/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import XCTest
import RxSwift

@testable import MyFirstSlideshow

class SlideShowViewModelTests: XCTestCase {
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

    func testCreateSlideShowViewModel() {
        let networking = Networking.init()
        let viewModel = SlideShowViewModel(picturePathStrings: imagesArray, networkSession: networking)

        let countExpectation = self.expectation(description: "Initial Image Count")

        viewModel.currentVideoIndex
            .subscribe(onNext: { count in
                XCTAssertEqual(count, 0)
                countExpectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }

    func testLoadImage() {
        let url = URL(fileURLWithPath: oneImageArray.first!)
        stubImage(url: url)

        let networking = Networking.init()
        let viewModel = SlideShowViewModel(picturePathStrings: oneImageArray, networkSession: networking)
        
        let countExpectation = self.expectation(description: "Initial Image Count")

        viewModel.videoThumbnail
            .subscribe(onNext: { image in
                countExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        viewModel.nextPictureEventObserver.onNext(())

        waitForExpectations(timeout: 0.5, handler: nil)
    }
}
