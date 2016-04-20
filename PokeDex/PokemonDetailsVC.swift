//
//  PokemonDetailsVC.swift
//  PokeDex
//
//  Created by Srikant Viswanath on 4/10/16.
//  Copyright © 2016 Srikant Viswanath. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    var pokemonSegued: Pokemon!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBAction func backToPokeList(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemonSegued.pokeName.capitalizedString
        mainImg.image = UIImage(named: "\(pokemonSegued.pokedexId)")
        self.pokedexLbl.text = "\(pokemonSegued.pokedexId)"
        pokemonSegued.downloadPokemonDetails{ () ->() in
            self.updateUIAfterNetworkCall()
        }
    }
    
    func updateUIAfterNetworkCall(){
        typeLbl.text = self.pokemonSegued.pokeType
        defenseLbl.text = self.pokemonSegued.defense
        heightLbl.text = self.pokemonSegued.height
        descriptionLbl.text = self.pokemonSegued.description
        weightLbl.text = self.pokemonSegued.weight
        attackLbl.text = self.pokemonSegued.attack
        nextEvoImg.image = UIImage(named: "\(pokemonSegued.nextEvolutionId)")
        if pokemonSegued.nextEvolutionName != "" {
            evoLbl.text = "Next Evolution: \(self.pokemonSegued.nextEvolutionName) at Lvl \(pokemonSegued.nextEvolutionId)"
            currentEvoImg.image = mainImg.image
        }else{
            evoLbl.text = "Pokemon at its highest evolution form"
            currentEvoImg.image = nil
        }
        prepareNextEvoBio()
    }
    
    func prepareNextEvoBio(){
        if pokemonSegued.nextEvolutionId != ""{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PokemonDetailsVC.nextEvoPressed))
            nextEvoImg.addGestureRecognizer(tapGesture)
            nextEvoImg.userInteractionEnabled = true
        }
    }
    
    func nextEvoPressed(){
        pokemonSegued = Pokemon(name: pokemonSegued.nextEvolutionName, pokedexId: Int(pokemonSegued.nextEvolutionId)!)
        self.viewDidLoad()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
