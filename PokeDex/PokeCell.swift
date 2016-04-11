//
//  PokeCell.swift
//  PokeDex
//
//  Created by Srikant Viswanath on 4/4/16.
//  Copyright © 2016 Srikant Viswanath. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 6.0
    }
    
    func configureCell(pokemon: Pokemon){
        self.nameLbl.text = pokemon.name.capitalizedString
        self.thumbImg.image = UIImage(named: "\(pokemon.pokedexId)")
    }
    
}
