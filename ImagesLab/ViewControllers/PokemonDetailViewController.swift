//
//  PokemonDetailViewController.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/7/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var weaknessLabel: UILabel!
    
    @IBOutlet weak var setLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settheLabels()
        loadImage()
    }
    
    func settheLabels() {
        nameLabel.text = pokemon.name
        typeLabel.text = pokemon.types[0]
        weaknessLabel.text = pokemon.weaknesses[0].type
        setLabel.text = pokemon.set
    }
    
    func loadImage() {
        ImageHelper.shared.getImage(urlStr: pokemon.imageUrlHiRes) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.pokemonImage.image = imageFromOnline
                }
            }
        }
    }
 
}
