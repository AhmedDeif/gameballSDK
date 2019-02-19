//
//  Extenstons.swift
//  gameball_SDK
//
//  Created by Omar Ali on 2/15/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

extension Bundle {
    static var sdkBundle: Bundle? {
        return Bundle.init(identifier: "Abodeif.gameball-SDK")
    }
}

extension UIImage {
    
    static func image(named name: String) -> UIImage? {
        return UIImage(named: name, in: Bundle.sdkBundle, compatibleWith: nil)
    }
    
}

