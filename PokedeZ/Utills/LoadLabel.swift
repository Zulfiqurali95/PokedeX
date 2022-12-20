//
//  AppDelegate.swift
//  PokedeZ
//
//  Created by Zulfiqur Ali on 12/10/22.
//
import Foundation
import UIKit

class LazyLoadLabel: UILabel{
    func loadLabel(fromURL labelURL: URL){
        DispatchQueue.global().async {
          
        URLSession.shared.getRequest(url: URL(string: "\(labelURL)"), decoding: PokemonData.self){ [weak self] result in
            switch result{
            case .success(let label):
                
               
            DispatchQueue.main.async{
                self?.text = label.types[0].type.name?.capitalized
                }
        case .failure(let error):
            print(error)
            }
        }
    }
}
}
