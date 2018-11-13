//
//  StarshipViewController.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit

class StarshipViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    
    let client = SwapAPIClient()
    var allStarships = [Starships]() {
        didSet {
            starshipPickerView.reloadAllComponents()
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
    @IBOutlet weak var starshipClassLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    @IBOutlet weak var starshipPickerView: UIPickerView!
    
    @IBOutlet weak var exchangeRateField: UITextField!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    
    @IBOutlet weak var creditsButton: UIButton!
    @IBOutlet weak var dollarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Starships"
        
        starshipPickerView.dataSource = self
        starshipPickerView.delegate = self
        exchangeRateField.delegate = self
        
        exchangeRateField.text = "0.0"
        
        let starship = endpointDetails(idType: .starships)
        
        client.retrieveSWJson(with: starship) { jsonArray, error in
            
            guard let jsonArray = jsonArray else {
                print("jsonArray is empty")
                return
            }
            
            self.allStarships = jsonArray.compactMap { Starships(json: $0) }
            print(self.allStarships.count)
            
            self.allStarships.sort(by: { $0.sortLengthValue > $1.sortLengthValue })
            
            self.nameLabel.text = self.allStarships.first?.name
            self.makeLabel.text = self.allStarships.first?.make
            self.lengthLabel.text = self.allStarships.first?.length
            self.starshipClassLabel.text = self.allStarships.first?.classType
            self.crewLabel.text = self.allStarships.first?.crew
            self.costLabel.text = self.allStarships.first?.cost
            
            self.smallestLabel.text = self.allStarships.last?.name
            self.largestLabel.text = self.allStarships.first?.name
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


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allStarships.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allStarships[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameLabel.text = allStarships[row].name
        costLabel.text = allStarships[row].cost
        makeLabel.text = allStarships[row].make
        lengthLabel.text = allStarships[row].length
        sortedLength = allStarships[row].sortLengthValue
        starshipClassLabel.text = allStarships[row].classType
        crewLabel.text = allStarships[row].crew
        
        if let costUnwrapped = allStarships[row].cost {
            returnedCost = Double(costUnwrapped)
        }
        
        smallestLabel.text = allStarships.last?.name
        largestLabel.text = allStarships.first?.name
        
    }
    
    
    
    
    
    
    
    
    



}
