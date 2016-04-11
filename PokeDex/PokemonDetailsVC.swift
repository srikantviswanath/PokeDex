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
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = dataSentFromCollectionView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
