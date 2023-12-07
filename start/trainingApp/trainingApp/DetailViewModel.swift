//
//  DetailViewModel.swift
//  trainingApp
//
//  Created by MacBook on 17/11/2023.
//

import Foundation

import Foundation

class DetailViewModel {
    
    private var network = Network()

    func getMarvels(completion: @escaping ([Marvel]) -> Void) {
        network.fetchMarvelCharacters { marvels in
            DispatchQueue.main.async {
                completion(marvels ?? [])
            }
        }
    }
}


