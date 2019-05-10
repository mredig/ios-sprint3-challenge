//
//  PokemonController.swift
//  Pokesearch
//
//  Created by Michael Redig on 5/10/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import UIKit

class PokemonController {
	var pokemons: [Pokemon] = []


	func catchPokemon(_ pokemon: Pokemon) {
		pokemons.append(pokemon)
	}

	//MARK:- Netstuff

	let baseURL = URL(string: "https://pokeapi.co/api/v2")!
	let networkHandler = NetworkHandler()

	func getAllPokemon() {
		fatalError()
	}

	func searchForPokemon(named: String, completion: @escaping (Result<Pokemon, Error>)->Void) {
		var pokeSearchURL = baseURL.appendingPathComponent("pokemon")
		pokeSearchURL = pokeSearchURL.appendingPathComponent(named)

		var request = URLRequest(url: pokeSearchURL)
		request.httpMethod = HTTPMethods.get.rawValue

		networkHandler.fetchMahDatas(with: request) { [weak self] (_, data, error) in
			if let error = error {
				completion(.failure(error))
				return
			}

			guard let data = data else {
				completion(.failure(NetworkError.badData))
				return
			}

			let decoder = JSONDecoder()
			do {
				let newPokemon = try decoder.decode(Pokemon.self, from: data)
//				self?.pokemons.append(newPokemon)
				completion(.success(newPokemon))
			} catch {
				completion(.failure(error))
			}
		}
	}

	func getSprite(withURLString urlString: String, completion: @escaping (Result<(id: String, image: UIImage), Error>) -> Void) {

	}
}