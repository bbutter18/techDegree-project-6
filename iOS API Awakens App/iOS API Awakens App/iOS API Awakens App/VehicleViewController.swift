//
//  VehicleViewController.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit

class VehicleViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    let client = SwapAPIClient()
    var allVehicles = [Vehicles]() {
        didSet {
            vehiclePickerView.reloadAllComponents()
        }
    }
    
    let englishUnit = 3.28 //conversion of meters to feet
    let metricUnit = 1.0 //no conversion since already in meters
    var sortedLength: Double? = nil
    var returnedCost: Double? = nil
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var vehicleClassLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    @IBOutlet weak var vehiclePickerView: UIPickerView!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    @IBOutlet weak var dollarButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    
    @IBOutlet weak var exchangeRateField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Vehicles"
        
        vehiclePickerView.delegate = self
        vehiclePickerView.dataSource = self
        exchangeRateField.delegate = self
        
        exchangeRateField.text = "0.0"

        let vehicle = endpointDetails(idType: .vehicles)
        
        client.retrieveSWJson(with: vehicle) { jsonArray, error in
            
            guard let jsonArray = jsonArray else {
                print("jsonArray is empty")
                return
            }
        
            self.allVehicles = jsonArray.compactMap { Vehicles(json: $0) }
            print(self.allVehicles.count)
        
        
            self.allVehicles.sort(by: { $0.sortLengthValue > $1.sortLengthValue })
            
            self.nameLabel.text = self.allVehicles.first?.name
            self.makeLabel.text = self.allVehicles.first?.make
            self.lengthLabel.text = self.allVehicles.first?.length
            self.vehicleClassLabel.text = self.allVehicles.first?.classType
            self.crewLabel.text = self.allVehicles.first?.crew
            self.costLabel.text = self.allVehicles.first?.cost
            
            self.smallestLabel.text = self.allVehicles.last?.name
            self.largestLabel.text = self.allVehicles.first?.name
            
        }
        
    }

    
    
    @IBAction func englishMeasurementButton(_ sender: Any) {
        let convertedLength = sortedLength
        
        if let currentValue = convertedLength {
            let result = currentValue * englishUnit
            lengthLabel.text = "\(result)ft"
        }
        
    }
    
    
    
    @IBAction func metricMeasurementButton(_ sender: Any) {
        let convertedLength = sortedLength
        
        if let currentValue = convertedLength {
            let result = currentValue / metricUnit
            lengthLabel.text = "\(result)m"
        }
        
    }
    
    
   
    @IBAction func dollarConversionButton(_ sender: Any) {
        if let insertedRate = Double(exchangeRateField.text!) {
            if insertedRate > 0 {
                if let returnedCostUnwrapped = returnedCost {
                    let result = insertedRate * returnedCostUnwrapped
                    costLabel.text = "$\(result)"
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Rate must be larger than zero \nPlease enter below", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func creditsConversionButton(_ sender: Any) {
        costLabel.text = String(returnedCost!)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allVehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allVehicles[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameLabel.text = allVehicles[row].name
        costLabel.text = allVehicles[row].cost
        makeLabel.text = allVehicles[row].make
        lengthLabel.text = allVehicles[row].length
        sortedLength = allVehicles[row].sortLengthValue
        vehicleClassLabel.text = allVehicles[row].classType
        crewLabel.text = allVehicles[row].crew
        
        if let costUnwrapped = allVehicles[row].cost {
            returnedCost = Double(costUnwrapped)
        }
        
        smallestLabel.text = allVehicles.last?.name
        largestLabel.text = allVehicles.first?.name
        
    }
    
    
    
    
    
    
    
    
    
    
}
