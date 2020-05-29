//
//  QRController.swift
//  Obra Plates WatchKit Extension
//
//  Created by Jose Aguilar on 12/28/18.
//  Copyright © 2018 Obra Worldwide. All rights reserved.
//

import WatchKit
import Foundation

// Get Pass Code
// Present

class QRController: WKInterfaceController {
    
    @IBOutlet weak var imageView: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        updateImage()
        
    }
    
    func updateImage() {
        let generator = Code39()
        let code = codeValue
        if generator.isValid(code.uppercased()) {
            let encoded = generator.encode(code)
            let image = generator.drawCompleteBarcode(encoded)
            imageView.setImage(image)
        }
    }
    
    var codeValue: String {
        get {
            let defaults = UserDefaults.standard
            let key = "CodeValue"
            if let value = defaults.string(forKey: key) {
                return value
            }
            return "80621"
        }
        set {
            let defaults = UserDefaults.standard
            let key = "CodeValue"
            defaults.set(newValue, forKey: key)
        }
    }
    
    
    @IBAction func adjustMenuSelected() {
        self.presentTextInputController(withSuggestions: ["80621"], allowedInputMode: .plain) { (results) in
            if let result1 = results?[0] as? String {
                let generator = Code39()
                if generator.isValid(result1) {
                    self.codeValue = result1
                    self.updateImage()
                }
            }
            
        }
    }
}
