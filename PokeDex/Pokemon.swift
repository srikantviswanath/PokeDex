//
//  Pokemon.swift
//  PokeDex
//
//  Created by Srikant Viswanath on 4/4/16.
//  Copyright © 2016 Srikant Viswanath. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _pokeName: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _weight: String!
    private var _height: String!
    private var _attack: String!
    private var nextEvolutionText: String!
    private var _pokemonUrl: String!
    
    
    
    var pokeName: String{
        return _pokeName
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int){
        self._pokeName = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: _pokemonUrl)
        Alamofire.request(.GET, url!).responseJSON{ response in
            let result = response.result
            if let jsonDict = result.value as? Dictionary<String, AnyObject>{
                
                if let weight = jsonDict["weight"], height = jsonDict["height"], attack = jsonDict["attack"], defense = jsonDict["defense"], desc = jsonDict["descriptopn"]{
                    self._weight = weight as! String
                    self._height = height as! String
                    self._attack = "\(attack)"
                    self._defense = "\(defense)"
                    self._description = desc as! String
                }
                
                if let types = jsonDict["types"] as? [Dictionary<String, String>] where types.count>0{
                    if let type = types[0]["name"]{
                        self._type = type.capitalizedString
                    }
                    if types.count > 1{
                        for var idx=1; idx < types.count; idx++ {
                            self._type! += "/\(types[idx]["name"]!.capitalizedString)"
                        }
                    }
                }
                print(jsonDict)
                
            }
        }
    }
}

