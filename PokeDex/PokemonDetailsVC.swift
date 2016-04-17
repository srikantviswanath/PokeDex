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
    @IBAction func backToPokeList(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemonSegued.pokeName
        mainImg.image = UIImage(named: "\(pokemonSegued.pokedexId)")
        pokemonSegued.downloadPokemonDetails{ () ->() in
            //This will be executed after download has successfully finished
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
