//
//  UIImageExtension.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 27/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import UIKit


extension UIImage: FileManagerInitiable {
    
    var relativePathName: String {
        return self.hashValue.description
    }
    func dataRepresentation() -> Data? {
        return self.pngData()
    }
}
