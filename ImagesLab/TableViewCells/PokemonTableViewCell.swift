//
//  PokemonTableViewCell.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/6/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
