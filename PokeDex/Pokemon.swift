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
    private var _nextEvolutionId: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    /*Getters*/
    var pokeName: String{return _pokeName}
    var pokedexId: Int{return _pokedexId}
    var pokeType: String{
        if _type == nil{_type = ""}
        return _type
    }
    var description: String{
        if _description == nil{_description = ""}
        return _description
    }
    var defense: String{
        if _defense == nil{_defense = ""}
        return _defense
    }
    var weight: String{
        if _weight == nil{_weight = ""}
        return _weight
    }
    var height: String{
        if _height == nil{_height = nil}
        return _height
    }
    var attack: String{
        if _attack == nil{_attack = ""}
        return _attack
    }
    var nextEvolutionId: String{
        if _nextEvolutionId == nil{_nextEvolutionId = ""}
        return _nextEvolutionId
    }
    var nextEvolutionName: String{
        if _nextEvolutionName == nil{_nextEvolutionName = ""}
        return _nextEvolutionName
    }
    var nextEvolutionLvl: String{
        if _nextEvolutionLvl == nil{_nextEvolutionLvl = ""}
        return _nextEvolutionLvl
    }
    var pokemonUrl: String{return _pokemonUrl}

    
    
    
    init(name: String, pokedexId: Int){
        self._pokeName = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: _pokemonUrl)
        
        /*GET REQUEST for the outer json*/
        Alamofire.request(.GET, url!).responseJSON{ response in
            let result = response.result
            if let jsonDict = result.value as? Dictionary<String, AnyObject>{
                /*Retrival of standard key, values from json*/
                if let weight = jsonDict["weight"], height = jsonDict["height"], attack = jsonDict["attack"], defense = jsonDict["defense"]{
                    self._weight = weight as! String
                    self._height = height as! String
                    self._attack = "\(attack)"
                    self._defense = "\(defense)"
                }
                /*For more than one type, storing them with the "/" separator*/
                if let types = jsonDict["types"] as? [Dictionary<String, String>] where types.count>0{
                    if let type = types[0]["name"]{
                        self._type = type.capitalizedString
                    }
                    if types.count > 1{
                        for idx in 1 ..< types.count {
                            self._type! += "/\(types[idx]["name"]!.capitalizedString)"
                        }
                    }
                }
                /*Making another GET request for description as it is stored as an Url having an array of dictionaries*/
                if let descAttr = jsonDict["descriptions"] as? [Dictionary<String, String>] where descAttr.count>0{
                    if let url = descAttr[0]["resource_uri"]{
                        let fullNsUrl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, fullNsUrl).responseJSON{ response in
                            let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject>{
                                if let pokeDescription = descDict["description"] as? String{
                                    self._description = pokeDescription
                                }
                            }
                            completed()
                        }
                        
                    }
                }else{
                    self._description = "Default Pokemon Description"
                }
                /*Grabbing hold of next evolution data*/
                if let evolutions = jsonDict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count>0{
                    if let nextEvoName = evolutions[0]["to"] as? String{
                        //mega evolutions not supported by the app right now
                        if nextEvoName.rangeOfString("mega") == nil{
                            if let evoUrl = evolutions[0]["resource_uri"] as? String{
                                let staticBaseUrl = evoUrl.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let evoId = staticBaseUrl.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = evoId
                                self._nextEvolutionName = nextEvoName
                            }
                            if let nextEvoLvl = evolutions[0]["level"] as? Int{
                                self._nextEvolutionLvl = "\(nextEvoLvl)"
                            }
                        }
                    }
                }
            }
        }
    }
}

