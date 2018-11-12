//
//  ViewController.swift
//  Pokemon
//
//  Created by Gabriela Torres on 11/12/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    //Make Outlets
    @IBOutlet weak var PokemonNameTextField: UITextField!
    @IBOutlet weak var PokemonInfoTextView: UITextView!

    //URL for the pokemon
    let pokemonURL = "https://pokeapi.co/api/v2/pokemon/"
    
    var pokeId = ""
    var pokeName = ""
    var pokeAbilities = ""
    var pokeHeight = ""
    var pokeWeight = ""
    var pokeForms = ""
    var pokeArea = ""
    var pokeMoves = ""
    var pokeSpecies = ""
    var pokeStats = ""
    var pokeType = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //IBAction for the submit button
    @IBAction func SubmitButtonTapped(_ sender: Any) {
        //Dismissing keyboard
        PokemonNameTextField.resignFirstResponder()
        
        //Checking
        guard let pokemonName = PokemonNameTextField.text else {
            return
        }
        
        //Clearing out textfield
        PokemonNameTextField.text = ""
        
        //Replacing space in name/ title with + so they can be used as part of the url
        let pokemonNameURLComponet = pokemonName.replacingOccurrences(of: " ", with: "+")
        
        //Building our complete request url with name/song
        let requestURL = pokemonURL + pokemonNameURLComponet + "/"
        
        //Alamofire request and JSON response
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
                
                //If the code success
            case.success(let value):
                let json = JSON(value)
                self.PokemonInfoTextView.text = json["Information"].stringValue
                var pokeId = json["id"].stringValue
                var pokeNames = json["name"].stringValue
                
                //Preparing format for organized info
                let format = """
                Name: \(pokeNames.self)
                Id: \(pokeId.self)
                Stats:
                Type:
                Species:
                Forms:
                Height:
                Weight:
                Location:
                Moves:
                Abilities:
                """
                
                //If the code fails
            case.failure(let error):
                self.PokemonInfoTextView.text = "Try Again"
                print(error.localizedDescription)
            }
        }
    }
}

