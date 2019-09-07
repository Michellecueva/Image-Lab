//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/6/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    
    var pokemons = [Pokemon]() {
        didSet {
            pokemonTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    private func configureTableView() {
        pokemonTableView.dataSource = self
        pokemonTableView.rowHeight = 160
        
    }
    
    private func loadData() {
        
        PokemonAPIHelper.shared.getPokemon { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let pokemonFromJSON):
                    self.pokemons = pokemonFromJSON
                }
            }
        }
    }
}
extension PokemonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        
        let currentPokemon = pokemons[indexPath.row]
       
        ImageHelper.shared.getImage(urlStr: currentPokemon.imageUrl) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    cell.pokemonImage.image = imageFromOnline
                }
            }
            
        }
        
        return cell
    }
    
    
}
