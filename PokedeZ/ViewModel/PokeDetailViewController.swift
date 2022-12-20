//
//  AppDelegate.swift
//  PokedeZ
//
//  Created by Zulfiqur Ali on 12/11/22.
//

import UIKit

class PokeDetailViewController: UIViewController {

    @IBOutlet weak var pokeDetailImg: UIImageView!
    @IBOutlet weak var pokeDetailName: UILabel!
    @IBOutlet weak var pokeAbility1: UILabel!
    @IBOutlet weak var pokeAbility2: UILabel!
    @IBOutlet weak var pokeMoves: UILabel!
    
    var pokeSelectedURL: String?
    var pokeMovimientos:String = "Avaiable moves: "
    var pokeMovesAvaiable:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPokedexData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchPokedexData(){
        URLSession.shared.getRequest(url: URL(string: pokeSelectedURL ?? "https://pokeapi.co/api/v2/pokemon/ditto"), decoding: PokemonData.self){ [weak self] result in
            switch result{
        case .success(let pokemon):
            //self?.pokedexEntries = pokemon
            DispatchQueue.main.async{
                let url = URL(string: pokemon.sprites.other.arteOficial.front_default!)
                if let data = try? Data(contentsOf: url!){
                    self!.pokeDetailImg.image = UIImage(data: data)
                }
                self!.pokeDetailName.text = "\(pokemon.name!.capitalized) \n Type: \(pokemon.types[0].type.name!)"
                self!.pokeAbility1.text = "Ability 1: \(pokemon.abilities[0].ability.name ?? "no first ability".capitalized)"
                if pokemon.abilities.indices.contains(1){
                self!.pokeAbility2.text = "Ability 2: \(pokemon.abilities[1].ability.name ?? "no second ability".capitalized)"
                }
                
                self!.pokeMovesAvaiable = pokemon.moves.count
                for movimientos in pokemon.moves{
                    self?.pokeMovimientos += " " + movimientos.move.name!
                }
                self!.pokeMoves.text = self!.pokeMovimientos
                
                }
        case .failure(let error):
            print(error)
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
