//
//  BarWeightController.swift
//  Obra Plates WatchKit Extension
//
//  Created by Jose Aguilar on 12/28/18.
//  Copyright © 2018 Obra Worldwide. All rights reserved.
//

import WatchKit
import Foundation

class BarWeightController: WKInterfaceController {
    
    // Objects
    @IBOutlet weak var barPicker: WKInterfacePicker!
    @IBOutlet weak var adjustButton: WKInterfaceButton!
    @IBOutlet weak var cancelButton: WKInterfaceButton!
    
    // Logic
    let barWeights: [WKPickerItem] = {
        var barWeights: [WKPickerItem] = [WKPickerItem(title: "Barbell (45lbs)"),
                                          WKPickerItem(title: "Trap (45lbs)"),
                                          WKPickerItem(title: "Safety (60lbs)"), // 2
                                          WKPickerItem(title: "Cambered (45lbs)"),
                                          WKPickerItem(title: "Swiss (35lbs)"), //4
                                          WKPickerItem(title: "EZ (15lbs)")] //5
        return barWeights
    }()
    var selectedBarIndex: Int = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        barPicker.setItems(barWeights)
        barPicker.setSelectedItemIndex(lastValueIndex)
        adjustButton.setHighlightedTitle("Adjust")
        cancelButton.setDestructiveTitle("Cancel")
    }
    
    override func willActivate() {
        // Here
        super.willActivate()
    }
    
    override func didDeactivate() {
        // Here
        super.didDeactivate()
    }
    
    @IBAction func pickerChanged(_ value: Int) {
        selectedBarIndex = value
    }
    
    
    @IBAction func adjustButtonTapped() {
        lastValueIndex = selectedBarIndex
        
        switch selectedBarIndex {
        case 2:
            BarWeightController.lastValue = 60
        case 4:
            BarWeightController.lastValue = 35
        case 5:
            BarWeightController.lastValue = 15
        default:
            BarWeightController.lastValue = 45
        }
        
        dismiss()
    }
    
    static var lastValue: Double {
        get {
            let defaults = UserDefaults.standard
            let key = "SelectedBarValue"
            if defaults.double(forKey: key) > 0 {
                return defaults.double(forKey: key)
            }
            return 45
        }
        set {
            let defaults = UserDefaults.standard
            let key = "SelectedBarValue"
            defaults.set(newValue, forKey: key)
        }
    }
    
    var lastValueIndex: Int {
        get {
            let defaults = UserDefaults.standard
            let key = "SelectedBarIndex"
            if defaults.integer(forKey: key) >= 0 {
                return defaults.integer(forKey: key)
            }
            return 0
        }
        set {
            let defaults = UserDefaults.standard
            let key = "SelectedBarIndex"
            defaults.set(newValue, forKey: key)
        }
    }
    
    
    @IBAction func cancelButtonTapped() {
        dismiss()
    }
    
}
