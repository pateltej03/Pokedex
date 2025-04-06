//
//  Pokemon.swift
//  Pokedex
//
//  Created by Tej Patel on 28/10/24.
//


import Foundation

struct Pokemon: Identifiable, Codable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let height: Double
    let weight: Double
    let weaknesses: [PokemonType]
    let prev_evolution: [Int]? 
    let next_evolution: [Int]?
    var captured: Bool = false

    var imageName: String {
        String(format: "%03d", id)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        types = try container.decode([PokemonType].self, forKey: .types)
        height = try container.decode(Double.self, forKey: .height)
        weight = try container.decode(Double.self, forKey: .weight)
        
        weaknesses = try container.decodeIfPresent([PokemonType].self, forKey: .weaknesses) ?? []
        prev_evolution = try container.decodeIfPresent([Int].self, forKey: .prev_evolution) ?? []
        next_evolution = try container.decodeIfPresent([Int].self, forKey: .next_evolution) ?? []
    }

    enum CodingKeys: String, CodingKey {
        case id, name, types, height, weight, weaknesses, prev_evolution, next_evolution, captured
    }
}


