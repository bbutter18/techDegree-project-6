//
//  ViewController.swift
//  iOS API Awakens App
//
//  Created by Woodchuck on 10/11/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //INSERT Button Actions
            //Insert segue in button actions

       
    func displayAlertError(with title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    @IBAction func CharacterButtonSelection(_ sender: Any) {
        performSegue(withIdentifier: "CharacterViewSegue", sender: nil)
            print("Performing Character Segue")
        
    }
    

    @IBAction func StarshipButtonSelection(_ sender: Any) {
        performSegue(withIdentifier: "StarshipViewSegue", sender: nil)
        print("Performing Starship Segue")
    }
    
    
    @IBAction func VehicleButtonSelection(_ sender: Any) {
        performSegue(withIdentifier: "VehicleViewSegue", sender: nil)
        print("Performing Vehicle Segue")
    }
    
}







