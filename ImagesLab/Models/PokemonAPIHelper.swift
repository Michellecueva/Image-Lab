//
//  PokemonAPIHelper.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/6/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct  PokemonAPIHelper {
    private init() {}
    
    static let shared = PokemonAPIHelper()
    
    let urlStr = "https://api.pokemontcg.io/v1/cards?contains=weaknesses"
    
    func getPokemon(completionHandler: @ escaping (Result<[Pokemon], AppError>) -> ()) {
        
        NetworkManager.shared.fetchData(urlString: urlStr) {
            (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let pokemonInfo = try JSONDecoder().decode(PokemonWrapper.self, from: data)
                    completionHandler(.success(pokemonInfo.cards))
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
