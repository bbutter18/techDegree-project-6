//
//  StarshipViewController.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit

class StarshipViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    let client = SwapAPIClient()
    var allStarships: [Starships] = []
    let englishUnit = 0.39
    let metricUnit = 100.0
    var sortedLength: Double? = nil
    var returnedCost: Double? = nil
    
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var starshipClassLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    @IBOutlet weak var starshipPickerView: UIPickerView!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Starships"
        
        let starship = endpointDetails(idType: .starships)
        
        client.retrieveSWJson(with: starship) { jsonArray, error in
            
            //*********PROBLEM AREA******************
            guard let jsonArray = jsonArray else {
                print("jsonArray is empty")
                return
            }
            
            let starships = jsonArray.flatMap { Starships(json: $0) }
            
            self.allStarships = starships
            
            self.allStarships.sort(by: { $0.sortHeightValue > $1.sortHeightValue })
            
            self.nameLabel.text = self.allStarships.first?.name
            self.makeLabel.text = self.allStarships.first?.make
            self.lengthLabel.text = self.allStarships.first?.length
            self.starshipClassLabel.text = self.allStarships.first?.classType
            self.crewLabel.text = self.allStarships.first?.crew
            self.costLabel.text = self.allStarships.first?.cost
        }
        
    }
    
    //***********************END PROBLEM AREA***********************

    
    
    @IBAction func dollarConversionButton(_ sender: Any) {
    }
    
    
    @IBAction func creditsConversionButton(_ sender: Any) {
    }
    


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
        lengthLabel.text = allStarships[row].length?.description
        //sortedLength = allStarships[row].length
        starshipClassLabel.text = allStarships[row].classType
        crewLabel.text = allStarships[row].crew
        
        smallestLabel.text = allStarships.last?.name
        largestLabel.text = allStarships.first?.name
        
    }
    
    
    
    
    
    
    
    
    



}
