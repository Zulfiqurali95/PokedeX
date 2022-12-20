//
//  AppDelegate.swift
//  PokedeZ
//
//  Created by Zulfiqur Ali on 12/10/22.
//

import Foundation
import UIKit

class PokeCell: UITableViewCell {

    @IBOutlet weak var pokeSprite: LazyImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeElement: LazyLoadLabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
