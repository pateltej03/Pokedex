//
//  PokemonListView.swift
//  Pokedex
//
//  Created by Tej Patel on 28/10/24.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if !viewModel.capturedPokemons.isEmpty {
                        PokemonRowView(title: "Captured", titleColor: .red, pokemons: viewModel.capturedPokemons, viewModel: viewModel)
                    }
                    
                    ForEach(PokemonType.allCases, id: \.self) { type in
                        PokemonRowView(title: type.rawValue, titleColor: .primary, pokemons: viewModel.pokemons.filter { $0.types.contains(type) }, viewModel: viewModel)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Pokédex")
                        .bold()
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity)
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: OldPokemonListView(viewModel: viewModel)) {
                        Text("All Pokémons")
                            .foregroundColor(.blue)
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PokemonRowView: View {
    let title: String
    let titleColor: Color
    let pokemons: [Pokemon]
    @ObservedObject var viewModel: PokemonViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(titleColor)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(viewModel: viewModel, pokemon: pokemon)) {
                            PokemonThumbnailView(pokemon: pokemon)
                        }
                    }
                }
            }
        }
        .padding(.leading)
    }
}


struct PokemonThumbnailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            Image(pokemon.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(pokemonType: pokemon.types.first ?? .normal))
                )
                .overlay(
                    Image(systemName: pokemon.captured ? "star.fill" : "star")
                        .foregroundColor(.red)
                        .padding(4),
                    alignment: .topTrailing
                )
            Text(pokemon.name)
                .font(.caption)
        }
    }
}

