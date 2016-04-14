//
//  PokemonDetailsVC.swift
//  PokeDex
//
//  Created by Srikant Viswanath on 4/10/16.
//  Copyright © 2016 Srikant Viswanath. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {
    
    var dataSentFromCollectionView: String!
    @IBOutlet weak var nameLbl: UILabel!
    @IBAction func backToPokeList(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = dataSentFromCollectionView
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
