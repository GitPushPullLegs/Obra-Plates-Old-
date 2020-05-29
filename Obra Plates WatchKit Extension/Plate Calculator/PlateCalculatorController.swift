//
//  PlateCalculatorController.swift
//  Obra Plates WatchKit Extension
//
//  Created by Jose Aguilar on 12/27/18.
//  Copyright © 2018 Obra Worldwide. All rights reserved.
//

import WatchKit
import Foundation

class PlateCalculatorController {
    
    private let lbValues: [Int] = Array(stride(from: 0, to: 1000, by: 5))
    private let kgValues: [Double] = Array(stride(from: 0, to: 454.0, by: 0.25))
    lazy var pickerValues: [WKPickerItem] = {
        var values: [WKPickerItem] = []
        let unit: [Any] = unitOfWeight == .kgs ? kgValues : lbValues
        unit.forEach { (each) in
            let item = WKPickerItem()
            item.title = "\(each)"
            values.append(item)
        }
        return values
    }()
    
    enum WeightUnit {
        case lbs, kgs
    }
    
    var unitOfWeight: WeightUnit {
        get {
            let defaults = UserDefaults.standard
            if defaults.bool(forKey: "WeightUnit") {
                return WeightUnit.kgs
            }
            return WeightUnit.lbs
        }
        set {
            let defaults = UserDefaults.standard
            if newValue == .kgs {
                defaults.set(true, forKey: "WeightUnit")
            } else {
                defaults.set(false, forKey: "WeightUnit")
            }
        }
    }
    
    init() {
    }
    
    struct ReturningPlateValues {
        var p45: String = "0"
        var p35: String = "0"
        var p25: String = "0"
        var p10: String = "0"
        var p5: String = "0"
        var p2p5: String = "0"
    }
    
    func valueChanged(_ value: Int, returnedValues: (ReturningPlateValues) -> Void) {
        returnedValues((calculatePlates(actualValue: unitOfWeight == .kgs ? kgValues[value] : Double(lbValues[value]))))
    }
    
    private func calculatePlates(actualValue: Double) -> ReturningPlateValues {
        var total = actualValue
        var returningPlateValues = ReturningPlateValues()
        total -= BarWeightController.lastValue
        total /= 2
        var returnValue = 0
        
        if isPlateEnabled(.p45) {
            while total >= 45 {
                total -= 45
                returnValue += 1
            }
            returningPlateValues.p45 = "\(returnValue)"
            returnValue = 0
        } else {
            returningPlateValues.p45 = "-1"
        }
        
        if isPlateEnabled(.p35) {
            while total >= 35 {
                total -= 35
                returnValue += 1
            }
            returningPlateValues.p35 = "\(returnValue)"
            returnValue = 0
        } else {
            returningPlateValues.p35 = "-1"
        }
        
        if isPlateEnabled(.p25) {
            while total >= 25 {
                total -= 25
                returnValue += 1
            }
            returningPlateValues.p25 = "\(returnValue)"
            returnValue = 0
        } else {
            returningPlateValues.p25 = "-1"
        }
        
        if isPlateEnabled(.p10) {
            while total >= 10 {
                total -= 10
                returnValue += 1
            }
            returningPlateValues.p10 = "\(returnValue)"
            returnValue = 0
        } else {
            returningPlateValues.p10 = "-1"
        }
        
        if isPlateEnabled(.p5) {
            while total >= 5 {
                total -= 5
                returnValue += 1
            }
            returningPlateValues.p5 = "\(returnValue)"
            returnValue = 0
        } else {
            returningPlateValues.p5 = "-1"
        }
        
        if isPlateEnabled(.p2p5) {
            while total >= 2.5 {
                total -= 2.5
                returnValue += 1
            }
            returningPlateValues.p2p5 = "\(returnValue)"
            returnValue = 0
        } else {
            returningPlateValues.p2p5 = "-1"
        }
        
        return returningPlateValues
    }
    
    enum Plates: String {
        case p45 = "P45Disabled"
        case p35 = "P35Disabled"
        case p25 = "P25Disabled"
        case p10 = "P10Disabled"
        case p5 = "P5Disabled"
        case p2p5 = "P2.5Disabled"
    }
    
    func plateTapped(plate: Plates) {
        let defaults = UserDefaults.standard

        defaults.set(!defaults.bool(forKey: plate.rawValue), forKey: plate.rawValue)
    }
    
    func isPlateEnabled(_ plate: Plates) -> Bool {
        let defaults = UserDefaults.standard
        return !defaults.bool(forKey: plate.rawValue)
    }
    
    var lastValue: Int {
        get {
            let defaults = UserDefaults.standard
            let key = "lastValue"
            if defaults.integer(forKey: key) >= 0 {
                return defaults.integer(forKey: key)
            }
            return 45
        }
        set {
            let defaults = UserDefaults.standard
            let key = "lastValue"
            defaults.set(newValue, forKey: key)
        }
    }
}
