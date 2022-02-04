//
//  PokemonNetworkController.swift
//  Pokedex
//
//  Created by adam smith on 2/3/22.
//

import Foundation
import UIKit.UIImage

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
                
                if let topLevelDictionary = try JSONSerialization.jsonObject(with: pokemonData, options: .fragmentsAllowed) as? [String: Any] {
                    
                let pokemon = Pokemon(dictionary: topLevelDictionary)
                    
                    completion(pokemon)
                }
            } catch {
                print("Encountered error when decoding the data")
                completion(nil)
            }
        }.resume()
    }
    
    static func getImage(from seachTerm: String, completion: @escaping (UIImage?) -> Void) {
        guard let baseUrl = URL(string: baseURLString) else {return}
        
        var urlComponents = URLComponents.init(url: baseUrl, resolvingAgainstBaseURL: true)
        
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                print("There was an error fetching the data. The url is \(finalURL), the error is \(error.localizedDescription)")
                completion(nil)
            }
            
            guard let data = data,
                  let image = UIImage(data: data)
            else { completion(nil); return }
            
            completion(image)
            
        }.resume()
    }
}
