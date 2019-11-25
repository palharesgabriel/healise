//
//  String+Extension.swift
//  MyBujo2.0
//
//  Created by Lucas Tavares on 25/11/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

extension String {
	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}
	
	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
}

