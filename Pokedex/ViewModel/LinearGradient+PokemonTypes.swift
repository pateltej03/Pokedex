//
//  LinearGradient+PokemonTypes.swift
//  Pokedex
//
//  Created by Tej Patel on 28/10/24.
//

import SwiftUI

extension LinearGradient {
    init(pokemonTypes: [PokemonType]) {
        let colors = pokemonTypes.map { Color(pokemonType: $0) }
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
