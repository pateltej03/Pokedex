//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Tej Patel on 28/10/24.
//

import SwiftUI

class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var selectedType: PokemonType? = nil
    
    private let dataLoader = PokemonDataLoader()
    
    init() {
        loadPokemon()
    }
    
    func loadPokemon() {
        pokemons = dataLoader.loadPokemonData()
    }
    
    func savePokemon() {
        dataLoader.savePokemonData(pokemons)
    }
    
    func toggleCapture(for pokemon: Pokemon) {
        if let index = pokemons.firstIndex(where: { $0.id == pokemon.id }) {
            pokemons[index].captured.toggle()
            savePokemon()
        }
    }
    
    func filteredPokemons() -> [Pokemon] {
        guard let type = selectedType else {
            return pokemons
        }
        return pokemons.filter { $0.types.contains(type) }
    }
    
    var capturedPokemons: [Pokemon] {
        pokemons.filter { $0.captured }
    }
}

class PokemonDataLoader {
    private let persistence = Persistence<[Pokemon]>(filename: "pokedex")
    
    func loadPokemonData() -> [Pokemon] {
        if let pokemons = persistence.modelData {
            print("Loaded data from persistence: \(pokemons.count) Pokémon")
            return pokemons
        }
        
        guard let url = Bundle.main.url(forResource: "pokedex", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let pokemons = try? JSONDecoder().decode([Pokemon].self, from: data) else {
            print("Failed to load or decode pokedex.json")
            return []
        }
        
        print("Loaded data from bundled JSON: \(pokemons.count) Pokémon")
        savePokemonData(pokemons)
        return pokemons
    }

    func savePokemonData(_ pokemons: [Pokemon]) {
        persistence.save(pokemons)
        print("Data saved successfully with \(pokemons.count) Pokémon.")
    }
}



