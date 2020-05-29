//
//  Code39Generator.swift
//  Obra Plates WatchKit Extension
//
//  Created by Jose Aguilar on 12/28/18.
//  Copyright © 2018 Obra Worldwide. All rights reserved.
//

import Foundation
import WatchKit

/// First check if it's valid, then encode the barcode, then draw it out.
class Code39 {
    private let alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%*"
    private let characterEncodings = [
        "1010011011010", "1101001010110", "1011001010110", "1101100101010", "1010011010110", "1101001101010",
        "1011001101010", "1010010110110", "1101001011010", "1011001011010", "1101010010110", "1011010010110",
        "1101101001010", "1010110010110", "1101011001010", "1011011001010", "1010100110110", "1101010011010",
        "1011010011010", "1010110011010", "1101010100110", "1011010100110", "1101101010010", "1010110100110",
        "1101011010010", "1011011010010", "1010101100110", "1101010110010", "1011010110010", "1010110110010",
        "1100101010110", "1001101010110", "1100110101010", "1001011010110", "1100101101010", "1001101101010",
        "1001010110110", "1100101011010", "1001101011010", "1001001001010", "1001001010010", "1001010010010",
        "1010010010010", "1001011011010"
    ]
    
    var fillColor = UIColor.white
    var strokeColor = UIColor.black
    
    private func encodeCharacterString(_ characterString:String) -> String {
        let location = alphabet.location(characterString)
        return characterEncodings[location]
    }
    
    
    // First check if the entry is valid
    func isValid(_ contents: String) -> Bool {
        if contents.length() > 0
            && contents.range(of: "*") == nil
            && contents == contents.uppercased() {
            for character in contents {
                let location = alphabet.location(String(character))
                if location == NSNotFound {
                    return false
                }
            }
            return true
        }
        return false
    } // End of isValid
    
    // Then generate the barcode
    func encode(_ contents: String) -> String {
        var barcode = ""
        for character in contents {
            barcode += self.encodeCharacterString(String(character))
        }
        let initiatorTerminator = self.encodeCharacterString("*")
        return "\(initiatorTerminator)\(barcode)\(initiatorTerminator)"
    }
    
    // Drawer for completed barcode.
    // 3rd draw the barcode
    func drawCompleteBarcode(_ completeBarcode:String) -> UIImage? {
        let length:Int = completeBarcode.length()
        if length <= 0 {
            return nil
        }
        
        // Values taken from CIImage generated AVMetadataObjectTypePDF417Code type image
        // Top spacing          = 1.5
        // Bottom spacing       = 2
        // Left & right spacing = 2
        // Height               = 28
        let width = length + 4
        let size = CGSize(width: CGFloat(width), height: 28)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setShouldAntialias(false)
            
            self.fillColor.setFill()
            self.strokeColor.setStroke()
            
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            context.setLineWidth(1)
            
            for i in 0..<length {
                if completeBarcode[i] == "1" {
                    let x = i + (2 + 1)
                    context.move(to: CGPoint(x: CGFloat(x), y: 1.5))
                    context.addLine(to: CGPoint(x: CGFloat(x), y: size.height - 2))
                }
            }
            context.drawPath(using: CGPathDrawingMode.fillStroke)
            let barcode = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let bigger = resizeImage(barcode!, scale: 5)
            return bigger
        } else {
            return nil
        }
    }
    
    // Resize image
    private func resizeImage(_ source:UIImage, scale:CGFloat) -> UIImage? {
        let width = source.size.width * scale
        let height = source.size.height * scale
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .none
        source.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let target = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return target
    }
}

fileprivate extension String {
    // Used in encodeCharacterString
    func location(_ other: String) -> Int {
        return (self as NSString).range(of: other).location
    }
    
    // Used in isValid
    func length() -> Int {
        return self.count
    }
    
    func substring(_ location:Int, length:Int) -> String! {
        return (self as NSString).substring(with: NSMakeRange(location, length))
    }
    
    subscript(index: Int) -> String! {
        get {
            return self.substring(index, length: 1)
        }
    }
}
