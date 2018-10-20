//
//  VehicleViewController.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit

class VehicleViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let client = SwapAPIClient()
    var allVehicles: [Vehicles] = []
    let englishUnit = 0.39
    let metricUnit = 100.0
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Vehicles"
        
        let vehicle = endpointDetails(idType: .vehicles)
        
        client.retrieveSWJson(with: vehicle) { vehicles, error in
            guard let vehicles = vehicles else {
                print("vehicles is empty")
                return
            }
            
            //*******************PROBLEM AREA*************************
            guard let vehicleInfo = vehicles.first else {
                completion(nil, .jsonParsingFailure(message: "Results does not contain vehicle information"))
                return
            }
            
            guard let vehicle = Vehicles(json: vehicleInfo) else {
                completion(nil, .jsonParsingFailure(message: "Could not parse vehicle information"))
                
            }
            
            let vehicleInfoResults = vehicles.flatMap { Vehicles(json: $0) }
            
            if let vehicleParsed = vehicle {
                self.allVehicles.append(vehicleParsed)
            }
            
            self.allVehicles.sort(by: { $0.sortHeightValue > $1.sortHeightValue })
            
            
        }
        
    }

    //****************************END PROBLEM AREA******************************
    
    
    @IBAction func englishMeasurementButton(_ sender: Any) {
        if let currentValue = sortedLength {
            let result = currentValue * englishUnit
            lengthLabel.text = "\(result)"
        }
        
    }
    
    
    
    @IBAction func metricMeasurementButton(_ sender: Any) {
        if let currentValue = sortedLength {
            let result = currentValue / metricUnit
            lengthLabel.text = "\(result)"
        }
        
    }
    
    
   
    //will do this later
    @IBAction func dollarConversionButton(_ sender: Any) {
    }
    
    
    //will doe this later
    @IBAction func creditsConversionButton(_ sender: Any) {
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
        lengthLabel.text = allVehicles[row].length?.description
        sortedLength = allVehicles[row].length
        vehicleClassLabel.text = allVehicles[row].classType
        crewLabel.text = allVehicles[row].crew
        
        smallestLabel.text = allVehicles.last?.name
        largestLabel.text = allVehicles.first?.name
        
    }
    
    
    
    
    
    
    
    
    
    
}
