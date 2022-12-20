//
//  AppDelegate.swift
//  PokedeZ
//
//  Created by Zulfiqur Ali on 12/10/22.
//

import Foundation

struct Pokedex: Codable{
    let count:Int?
    let next:String?
    let previous:String?
    let results: [PokeDetailLink]
}

struct PokeDetailLink: Codable{
    let name:String?
    let url:String?
}

struct PokemonData: Codable {
    let abilities: [AbilityElement]
    let moves: [PokeMovimientos]
    let name: String?
    let sprites: PokeSprites
    let types: [PokeTypes]
}


struct PokeSprites: Codable {
    let front_default:String?
    let other:PokemonArtwork
}

struct PokemonArtwork: Codable{
    let arteOficial: PokemonChosenArtwork
    private enum CodingKeys : String, CodingKey {
            case arteOficial = "official-artwork"
        }
}

struct PokemonChosenArtwork:Codable{
    let front_default:String?
}

struct AbilityElement: Codable {
    let ability: Ability
    let isHidden: Bool?
    let slot: Int?
}

struct Ability: Codable {
    let name: String?
    let url: String?
}

struct PokeTypes: Codable{
    let type: PokeElement
}

struct PokeElement: Codable{
    let name:String?
}

struct PokeMovimientos: Codable {
    let move: PokemonMovimiento
}

struct PokemonMovimiento: Codable{
    let name: String?
}
