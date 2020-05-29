//
//  InterfaceController.swift
//  Obra Plates WatchKit Extension
//
//  Created by Jose Aguilar on 12/27/18.
//  Copyright © 2018 Obra Worldwide. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var weightPicker: WKInterfacePicker!
    @IBOutlet weak var barWeight: WKInterfaceButton!
    
    @IBOutlet weak var plate45: WKInterfaceButton!    
    @IBOutlet weak var plate35: WKInterfaceButton!
    @IBOutlet weak var plate25: WKInterfaceButton!
    @IBOutlet weak var plate10: WKInterfaceButton!
    @IBOutlet weak var plate05: WKInterfaceButton!
    @IBOutlet weak var plate2p5: WKInterfaceButton!
    
    let controller = PlateCalculatorController()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        barWeight.setHighlightedTitle("\(Int(BarWeightController.lastValue))")
        
        weightPicker.setItems(controller.pickerValues)
        weightPicker.setSelectedItemIndex(controller.lastValue)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        updateButtons()
        barWeight.setHighlightedTitle("\(Int(BarWeightController.lastValue))")
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func pickerDidSettle(_ picker: WKInterfacePicker) {
        controller.lastValue = currentValue
    }

    var currentValue = 0
    @IBAction func pickerChanged(_ value: Int) {
        currentValue = value
        updateButtons()
    }
    
    func updateButtons() {
        controller.valueChanged(currentValue) { (returnedValues) in
            setPlate(plate45, weight: "45", returnedValue: returnedValues.p45)
            setPlate(plate35, weight: "35", returnedValue: returnedValues.p35)
            setPlate(plate25, weight: "25", returnedValue: returnedValues.p25)
            setPlate(plate10, weight: "10", returnedValue: returnedValues.p10)
            setPlate(plate05, weight: "5", returnedValue: returnedValues.p5)
            setPlate(plate2p5, weight: "2.5", returnedValue: returnedValues.p2p5)
        }
    }
    
    func setPlate(_ plate: WKInterfaceButton, weight: String, returnedValue: String) {
        switch returnedValue {
        case "0":
            plate.setWhiteTitle("\(weight) x \(returnedValue)")
        case "-1":
            plate.setDisabledTitle("\(weight) x 0")
        default:
            plate.setHighlightedTitle("\(weight) x \(returnedValue)")
        }
    }
    
    @IBAction func plate45Tapped() {
        controller.plateTapped(plate: .p45)
        updateButtons()
    }
    
    @IBAction func plate35Tapped() {
        controller.plateTapped(plate: .p35)
        updateButtons()
    }
    
    @IBAction func plate25Tapped() {
        controller.plateTapped(plate: .p25)
        updateButtons()
    }
    
    @IBAction func plate10Tapped() {
        controller.plateTapped(plate: .p10)
        updateButtons()
    }
    
    @IBAction func plate5Tapped() {
        controller.plateTapped(plate: .p5)
        updateButtons()
    }
    
    @IBAction func plate2p5Tapped() {
        controller.plateTapped(plate: .p2p5)
        updateButtons()
    }
    
    
    
    @IBAction func qrMenuOptionSelected() {
        self.pushController(withName: "QRControllerID", context: nil)
    }
}


