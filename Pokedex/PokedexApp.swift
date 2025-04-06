//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Tej Patel on 25/10/24.
//

import SwiftUI

@main
struct PokedexApp: App {
    @StateObject var viewModel = PokemonViewModel()
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            PokemonListView(viewModel: viewModel)
                .environmentObject(viewModel)
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive || phase == .background {
                        viewModel.savePokemon()
                    }
                }
        }
    }
}
