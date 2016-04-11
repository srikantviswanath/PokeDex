//
//  ViewController.swift
//  PokeDex
//
//  Created by Srikant Viswanath on 4/4/16.
//  Copyright © 2016 Srikant Viswanath. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var musicPlayer: AVAudioPlayer!

    var pokemonList = [Pokemon]()
    var filteredPokeMon = [Pokemon]()
    var searchEnabled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        parsePokemonCSV()
        initAudio()
    }

    @IBAction func musicBtnPressed(sender: UIButton!){
        if musicPlayer.playing{
            musicPlayer.stop()
            sender.alpha = 1.0
        }else{
            musicPlayer.play()
            sender.alpha = 0.2
        }
    }
    func initAudio(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let pokename = row["identifier"]
                let pokemon = Pokemon(name: pokename!, pokedexId: pokeId)
                pokemonList.append(pokemon)
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    /*UICollecionView's delegate methods*/
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchEnabled{
            return filteredPokeMon.count
        }
        return pokemonList.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pokemon: Pokemon!
        if searchEnabled{
            pokemon = filteredPokeMon[indexPath.row]
        }else{
            pokemon = pokemonList[indexPath.row]
        }
        performSegueWithIdentifier("PokemonDetailsVC", sender: pokemon)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            if searchEnabled{
                cell.configureCell(filteredPokeMon[indexPath.row])
            }else{
                cell.configureCell(pokemonList[indexPath.row])
            }
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    /*UISearchBar's delegate methods*/
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil{
            searchEnabled = false
            view.endEditing(true)
            collectionView.reloadData()
        }else{
            searchEnabled = true
            let tokenEntered = searchBar.text!.lowercaseString
            filteredPokeMon = pokemonList.filter({$0.name.rangeOfString(tokenEntered) != nil})
            collectionView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailsVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailsVC{
                if let poke = sender as? Pokemon{
                    detailsVC.dataSentFromCollectionView = poke.name
                }
            }
        }
    }
}

