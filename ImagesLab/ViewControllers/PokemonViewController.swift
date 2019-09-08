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
    
    var filteredPokemons: [Pokemon] {
        get {
            guard let searchString = searchString else { return pokemons }
            
            guard searchString != "" else { return pokemons}
            
            return Pokemon.getFilteredResults(arr: pokemons, searchText: searchString)
        }
    }
    
    var searchString: String? = nil {
        didSet {
            self.pokemonTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
        configureSearchBar()
    }
    
    private func configureTableView() {
        pokemonTableView.dataSource = self
        pokemonTableView.rowHeight = 500
        pokemonTableView.tableFooterView = UIView()
        
    }
    
    func configureSearchBar() {
        pokemonSearchBar.delegate = self
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
        return filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        
        let currentPokemon = filteredPokemons[indexPath.row]
       
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifier {
        case "pokemonSegue":
            guard let DetailVC = segue.destination as? PokemonDetailViewController else {fatalError("unexpected segueVC")}
            guard let selectedIndexPath = pokemonTableView.indexPathForSelectedRow else{fatalError("no row selected")}
            
            let pokemon = filteredPokemons[selectedIndexPath.row]
            
            DetailVC.pokemon = pokemon
        default:
            fatalError("unexpected segue identifies")
        }
    }
}

extension PokemonViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
}
