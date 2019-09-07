//
//  Pokemon.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/6/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct PokemonWrapper: Codable {
    let cards: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let imageUrl: String
    let imageUrlHiRes: String
    let types: [String]
    let weaknesses: [Weaknesses]
    let set: String
    
    static func getFilteredResults(arr: [Pokemon], searchText: String) -> [Pokemon] {
        var currentFilter: [Pokemon]
        currentFilter = arr.filter{$0.name.lowercased().contains(searchText.lowercased())}
        return currentFilter
    }
}

struct Weaknesses: Codable {
    let type: String
}
