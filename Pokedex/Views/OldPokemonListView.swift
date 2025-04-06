//
//  OldPokemonListView.swift
//  Pokedex
//
//  Created by Tej Patel on 04/11/24.
//

import SwiftUI

struct OldPokemonListView: View {
    @ObservedObject var viewModel: PokemonViewModel
    @State private var selectedType: PokemonType? = nil 
    
    var body: some View {
        NavigationStack {
            VStack {
                List(filteredPokemons) { pokemon in
                    NavigationLink(destination: PokemonDetailView(viewModel: viewModel, pokemon: pokemon)) {
                        OldPokemonRowView(pokemon: pokemon)
                    }
                    .padding(.trailing, 20)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparatorTint(Color.gray)
                }
                .listStyle(PlainListStyle())
            }
            .ignoresSafeArea(edges: .bottom)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Pokédex")
                        .bold()
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("No Filter") {
                            selectedType = nil
                        }
                        
                        ForEach(PokemonType.allCases, id: \.self) { type in
                            Button(type.rawValue) {
                                selectedType = type
                            }
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                }
            }
            .background(Color(.systemGray6))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var filteredPokemons: [Pokemon] {
        if let type = selectedType {
            return viewModel.pokemons.filter { $0.types.contains(type) }
        } else {
            return viewModel.pokemons 
        }
    }
}


struct OldPokemonRowView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack{
                    Text("       \(pokemon.id) ")
                        .fontWeight(.light)
                        .font(.system(size: 16))
                    Text("\(pokemon.name)")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }.padding(.horizontal, 20)
            }
            Spacer()
            
            Image(pokemon.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .background(
                    LinearGradient(pokemonTypes: pokemon.types)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                )
                .overlay(
                    Image(systemName: pokemon.captured ? "star.fill" : "star")
                        .foregroundColor(.red)
                        .padding(4),
                    alignment: .topTrailing
                )
        }
        .padding(.vertical, 25)
    }
}
