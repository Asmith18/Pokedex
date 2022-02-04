//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Karl Pfister on 2/3/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
   

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    var pokemon: Pokemon? {
        
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pokemonSearchBar.delegate = self
    }
    
    
   private func updateViews() {
        
        guard let pokemon = pokemon else { return }
        self.pokemonNameLabel.text = pokemon.name
       self.pokemonIDLabel.text = "\(pokemon.id)"
       pokemonMovesTableView.reloadData()
        
       PokemonNetworkController.getImage(from: pokemon.spritePath) { image in
            DispatchQueue.main.async {
                self.pokemonSpriteImageView.image = image
            }
        }
    }
}// End

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(pokemonMovesTableView)"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
     
        
        PokemonNetworkController.fetchPokemon(name: searchText) { pokemon in
            guard let pokemon = pokemon else { return }
        }
    }
    
    
}

