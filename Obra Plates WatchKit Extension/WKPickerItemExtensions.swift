//
//  WKPickerItemExtensions.swift
//  Obra Plates WatchKit Extension
//
//  Created by Jose Aguilar on 12/28/18.
//  Copyright © 2018 Obra Worldwide. All rights reserved.
//

import WatchKit
import Foundation

extension WKPickerItem {
    convenience init(icon: WKImage? = nil, title: String) {
        self.init()
        self.title = title
        self.contentImage = icon
    }
}
