//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Tej Patel on 28/10/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonViewModel
    let pokemon: Pokemon
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image(pokemon.imageName)
                        .resizable()
                        .frame(width: 375, height: 375)
                        .background(
                            LinearGradient(pokemonTypes: pokemon.types)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                        )
                    
                    Button(action: {
                        viewModel.toggleCapture(for: pokemon)
                        if pokemon.captured {
                            dismiss()
                        }
                    }) {
                        Text(pokemon.captured ? "Release" : "Capture")
                            .bold()
                            .padding()
                            .background(pokemon.captured ? Color.red : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text("Height")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                            HStack {
                                Text(String(format: "%.2f", pokemon.height))
                                    .fontWeight(.bold)
                                    .font(.system(size: 30))
                                Text("m")
                                    .fontWeight(.regular)
                                    .font(.system(size: 24))
                            }
                        }
                        Spacer()
                        VStack {
                            Text("Weight")
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                            HStack {
                                Text(String(format: "%.1f", pokemon.weight))
                                    .fontWeight(.bold)
                                    .font(.system(size: 30))
                                Text("kg")
                                    .fontWeight(.regular)
                                    .font(.system(size: 24))
                            }
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Text("Types")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(pokemon.types, id: \.self) { type in
                                Text(type.rawValue)
                                    .padding(8)
                                    .background(Capsule().fill(Color(pokemonType: type)))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Weaknesses")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(pokemon.weaknesses, id: \.self) { weakness in
                                Text(weakness.rawValue)
                                    .padding(8)
                                    .background(Capsule().fill(Color(pokemonType: weakness)))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    if let prev_evolutions = pokemon.prev_evolution, !prev_evolutions.isEmpty {
                        EvolutionSectionView(title: "Previous Evolutions", evolutionIDs: prev_evolutions, viewModel: viewModel)
                    }
                    
                    if let next_evolutions = pokemon.next_evolution, !next_evolutions.isEmpty {
                        EvolutionSectionView(title: "Next Evolutions", evolutionIDs: next_evolutions, viewModel: viewModel)
                    }
                    
                }
                .padding()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .bold()
                        Text("Pokédex")
                            .bold()
                            .font(.system(size: 20))
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                Text(pokemon.name)
                    .bold()
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity)
                
            }
        }
        .toolbarBackground(Color(.systemGray6), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EvolutionSectionView: View {
    let title: String
    let evolutionIDs: [Int]
    @ObservedObject var viewModel: PokemonViewModel
    
    private var filteredEvolutions: [Pokemon] {
        evolutionIDs.compactMap { id in
            viewModel.pokemons.first(where: { $0.id == id })
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filteredEvolutions, id: \.id) { evolution in
                        NavigationLink(destination: PokemonDetailView(viewModel: viewModel, pokemon: evolution)) {
                            PokemonThumbnailView(pokemon: evolution)
                                .padding(8)
                        }
                    }
                }
            }
        }
    }
}
