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
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                print("There was an error fetching the data. The url is \(finalURL), the error is \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let pokemonData = data else {
                print("fix me plz and thank you")
                completion(nil)
                return
                
            }
            
            do {
                
                guard let topLevelDictionary = try JSONSerialization.jsonObject(with: pokemonData, options: .fragmentsAllowed) as? [String: Any],
                      let pokemon = topLevelDictionary["pokemon"] as? [[String: Any]]
            else {
                    
                    print("unable to decerialize")
                    completion(nil)
                    return
                }
                
            } catch {
                print("Encountered error when decoding the data")
                completion(nil)
            }
        }.resume()
    }
}
