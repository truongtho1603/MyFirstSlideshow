//
//  PicturesModel.swift
//  MyFirstSlideshow
//
//  Created by Luan Bach on 27/11/2018.
//  Copyright © 2018 Yoti. All rights reserved.
//

import Foundation

struct PicturesModel {
    let picturePathStrings: [String]
    var count: Int {
        return picturePathStrings.count
    }
}
