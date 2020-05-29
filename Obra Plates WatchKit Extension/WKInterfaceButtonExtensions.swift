//
//  WKInterfaceButtonExtensions.swift
//  Obra Plates WatchKit Extension
//
//  Created by Jose Aguilar on 12/28/18.
//  Copyright © 2018 Obra Worldwide. All rights reserved.
//

import WatchKit
import Foundation

extension WKInterfaceButton {
    func setHighlightedTitle(_ title: String) {
        let greenBackgroundColor = UIColor(red: 4/255, green: 222/255, blue: 113/255, alpha: 0.14)
        self.setBackgroundColor(greenBackgroundColor)
        
        let greenTextColor = UIColor(red: 4/255, green: 222/255, blue: 113/255, alpha: 1.0)
        let greenTextAttributes = [NSAttributedString.Key.foregroundColor: greenTextColor]
        let greenText = NSAttributedString(string: title, attributes: greenTextAttributes)
        self.setAttributedTitle(greenText)
    }
    
    func setWhiteTitle(_ title: String) {
        let whiteBackground = UIColor(red: 242/255, green: 244/255, blue: 255/255, alpha: 0.14)
        self.setBackgroundColor(whiteBackground)
        
        let white = UIColor(red: 242/255, green: 244/255, blue: 255/255, alpha: 1)
        let whiteTextAttributes = [NSAttributedString.Key.foregroundColor: white]
        let text = NSAttributedString(string: title, attributes: whiteTextAttributes)
        self.setAttributedTitle(text)
    }
    
    func setDisabledTitle(_ title: String) {
        let whiteBackground = UIColor(red: 242/255, green: 244/255, blue: 255/255, alpha: 0.05)
        self.setBackgroundColor(whiteBackground)
        
        let white = UIColor(red: 242/255, green: 244/255, blue: 255/255, alpha: 0.5)
        let whiteTextAttributes = [NSAttributedString.Key.foregroundColor: white]
        let text = NSAttributedString(string: title, attributes: whiteTextAttributes)
        self.setAttributedTitle(text)
    }
    
    func setDestructiveTitle(_ title: String) {
        let color = UIColor(red: 250/255, green: 17/255, blue: 79/255, alpha: 1.0)
        self.setBackgroundColor(color.withAlphaComponent(0.17))
        
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        let text = NSAttributedString(string: title, attributes: attributes)
        self.setAttributedTitle(text)
    }
}
