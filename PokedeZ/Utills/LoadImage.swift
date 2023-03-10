//
//  AppDelegate.swift
//  PokedeZ
//
//  Created by Zulfiqur Ali on 12/10/22.
//

import Foundation
import UIKit
class LazyImageView: UIImageView{
    func loadImage(fromURL imageURL: URL, placeHolderImage: String){
        self.image = UIImage(named: placeHolderImage)
        
        DispatchQueue.global().async {
            [weak self] in
            
            if let imageData = try? Data(contentsOf: imageURL){
                if let image = UIImage(data: imageData){
                DispatchQueue.main.async {
                    self?.image = image
                }
                }
            }
        }
    }
}
