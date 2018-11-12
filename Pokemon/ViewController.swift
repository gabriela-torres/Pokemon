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
    @IBOutlet weak var PokemonNameTextField: UITextField!
    @IBOutlet weak var PokemonInfoTextView: UITextView!
    @IBOutlet weak var ImageView: UIImageView!
    
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
    
    @IBAction func SubmitButtonTapped(_ sender: Any) {
        PokemonNameTextField.resignFirstResponder()
        
        guard let pokemonName = PokemonNameTextField.text else {
            return
        }
        
        PokemonNameTextField.text = ""
        
        let pokemonNameURLComponet = pokemonName.replacingOccurrences(of: " ", with: "+")
        
        let requestURL = pokemonURL + pokemonNameURLComponet + "/"
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                self.PokemonInfoTextView.text = json["Information"].stringValue
            case.failure(let error):
                self.PokemonInfoTextView.text = "Try Again"
                print(error.localizedDescription)
            }
        }
    }
}

