//
//  PokemonNetworkController.swift
//  Pokedex
//
//  Created by adam smith on 2/3/22.
//

import Foundation

class PokemonNetworkController {
    
    private static let baseURLString = "https://pokeapi.co"
    
    
    
    static func fetchPokemon(name searchTerm: String, completion: @escaping ([Pokemon]?) -> Void) {
        
        guard let baseUrl = URL(string: baseURLString) else {return}
        
        var urlComponents = URLComponents.init(url: baseUrl, resolvingAgainstBaseURL: true)
        
        urlComponents?.path = "/api/v2/pokemon/\(searchTerm.lowercased())"
        
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
        
    }
}
