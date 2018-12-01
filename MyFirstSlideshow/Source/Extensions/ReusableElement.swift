//
//  ReusableElement.swift
//  ProceduresNavigator
//
//  Created by Luan Bach on 03/06/2018.
//  Copyright © 2018 Little Blue Dot. All rights reserved.
//

import UIKit

protocol ReusableElement {
    static var reuseIdentifier: String { get }
}

extension UICollectionViewCell: ReusableElement {
    static var reuseIdentifier: String {
        return "\(String(describing: self))ReuseIdentifier"
    }
}

