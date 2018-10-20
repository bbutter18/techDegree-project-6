//
//  CharacterViewController.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit

class CharacterViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let client = SwapAPIClient()
    var allCharacters: [Character] = []
    let englishUnit = 0.39
    let metricUnit = 100.0
    var sortedHeight: Double? = nil
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var homeworldLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var eyesLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    
    @IBOutlet weak var characterPickerView: UIPickerView!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Characters"
        
        let people = endpointDetails(idType: .characters)
        
        typealias characters = [String: Any]
        
        client.retrieveSWJson(with: people) { characters, error in
            
            guard let characters = characters else {
                print("characters is empty")
                return
            }
            
            //*********PROBLEM AREA******************
            guard let characterInfo = characters.first else {
                completion(nil, .jsonParsingFailure(message: "Results does not contain character information"))
                return
            }
            
            guard let character = Character(json: characterInfo) else {
                completion(nil, .jsonParsingFailure(message: "Could not parse character information"))
                
            }
            
            let characterInfoResults = characters.flatMap { Character(json: $0) }
            
            if let characterParsed = character {
                self.allCharacters.append(characterParsed)
            }
            
            self.allCharacters.sort(by: { $0.sortHeightValue > $1.sortHeightValue })
            
            
        } 
        
    }

    //***********************END PROBLEM AREA***********************
    
    
    @IBAction func englishMeasurementButton(_ sender: Any) {
        
        if let currentValue = sortedHeight {
            let result = currentValue * englishUnit
            heightLabel.text = "\(result)"
        }
    }
    
    
    @IBAction func metricMeasurementButton(_ sender: Any) {
        
        if let currentValue = sortedHeight {
            let result = currentValue / metricUnit
            heightLabel.text = "\(result)"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCharacters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allCharacters[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameLabel.text = allCharacters[row].name
        bornLabel.text = allCharacters[row].born
        heightLabel.text = allCharacters[row].height?.description
        sortedHeight = allCharacters[row].height
        eyesLabel.text = allCharacters[row].eyes
        hairLabel.text = allCharacters[row].hair
        
        smallestLabel.text = allCharacters.last?.name
        largestLabel.text = allCharacters.first?.name
        
    }
    
    
    

    
    
    
    

}
