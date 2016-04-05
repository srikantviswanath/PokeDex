//
//  Pokemon.swift
//  PokeDex
//
//  Created by Srikant Viswanath on 4/4/16.
//  Copyright © 2016 Srikant Viswanath. All rights reserved.
//

import Foundation

class Pokemon{
    var _name: String!
    var _pokedexId: Int!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}
