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
    var allCharacters = [Character]() {
        didSet {
            characterPickerView.reloadAllComponents()
        }
    }
    
    let englishUnit = 0.39 //conversion of centimeters to inches
    let metricUnit = 100.0 //conversion of centimeters to meters
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
    
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Characters"
        
        characterPickerView.dataSource = self
        characterPickerView.delegate = self
        
        let people = endpointDetails(idType: .people)
                
        client.retrieveSWJson(with: people) { jsonArray, error in
            
            guard let jsonArray = jsonArray else {
                print("jsonArray is empty")
                return
            }
            
            self.allCharacters = jsonArray.compactMap { Character(json: $0) }
            print(self.allCharacters.count)
            
            for character in self.allCharacters {

                if let url = character.home {
                    self.client.retrieveHomeworldInfo(with: url) { (json) in

                        let planet = HomeWorld(json: json)
                        print(planet)
                        DispatchQueue.main.async {
                        self.homeworldLabel.text = planet.name
                    }
                }
                }
            }
            self.allCharacters.sort(by: { $0.sortHeightValue > $1.sortHeightValue })
            
            self.nameLabel.text = self.allCharacters.first?.name
            self.bornLabel.text = self.allCharacters.first?.born
            self.heightLabel.text = self.allCharacters.first?.height
            self.eyesLabel.text = self.allCharacters.first?.eyes
            self.hairLabel.text = self.allCharacters.first?.hair
            self.homeworldLabel.text = self.allCharacters.first?.home
            print(self.homeworldLabel.text!)
            
            self.smallestLabel.text = self.allCharacters.last?.name
            self.largestLabel.text = self.allCharacters.first?.name
            
        }
    }
    
    
    @IBAction func englishMeasurementButton(_ sender: Any) {
        
        let convertedHeight = sortedHeight
        
        if let currentValue = convertedHeight {
            let result = currentValue * englishUnit
            heightLabel.text = "\(result)in"
        }
    }
    
    
    @IBAction func metricMeasurementButton(_ sender: Any) {
        
        let convertedHeight = sortedHeight
        
        if let currentValue = convertedHeight {
            let result = currentValue / metricUnit
            heightLabel.text = "\(result)m"
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
        print("text inside picker view")
        
        nameLabel.text = allCharacters[row].name
        homeworldLabel.text = allCharacters[row].home

        client.retrieveHomeworldInfo(with: (self.homeworldLabel.text)!) { (json) in
            
            let planet = HomeWorld(json: json)
            print(planet)
            DispatchQueue.main.async {
                self.homeworldLabel.text = planet.name
            }
        }
        
        bornLabel.text = allCharacters[row].born
        heightLabel.text = allCharacters[row].height
        sortedHeight = allCharacters[row].sortHeightValue
        eyesLabel.text = allCharacters[row].eyes
        hairLabel.text = allCharacters[row].hair

        smallestLabel.text = allCharacters.last?.name
        largestLabel.text = allCharacters.first?.name
        
    }
    
    
    

    
    
    
    

}
