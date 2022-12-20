//
//  AppDelegate.swift
//  PokedeZ
//
//  Created by Zulfiqur Ali on 12/10/22.
//
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var pokeOffset: Int = 0
    var pokeLoads: Int = 30
    var pokeIndex: Int = 1
    var segueIndex: Int = 0
    var pokedexSpiteURL:String?
    var pokemonElementType:String?
    var pokeChosen = [PokeDetailLink]()
    var isLoading = false
    override func viewDidLoad() {
        setupTableView()
        super.viewDidLoad()
        
    
    
        // Do any additional setup after loading the view.
        let tableViewLoadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
               self.tableView.register(tableViewLoadingCellNib, forCellReuseIdentifier: "loadingCellid")

        
    }
    func setupTableView(){
        
        fetchPokedex(pokemonOffset: pokeOffset, pokemonLoads: pokeLoads)
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func fetchPokedex(pokemonOffset: Int, pokemonLoads: Int){
        URLSession.shared.getRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(pokemonOffset)&limit=\(pokemonLoads)"), decoding: Pokedex.self){ [weak self] result in
            switch result{
        case .success(let pokemons):
            //self?.pokedexEntries = pokemon
                
                
            DispatchQueue.main.async{
                self?.pokeChosen += pokemons.results
                    self?.tableView.reloadData()
                }
        case .failure(let error):
            print(error)
            }
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return pokeChosen.count
                
            } else if section == 1 {
               
                return 1
            } else {
               
                return 0
            }
        }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokeCell
                cell.pokeName.text = pokeChosen[indexPath.row].name?.capitalized
                pokeIndex = indexPath.row
                let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokeIndex + 1).png")!
                if let data = try? Data(contentsOf: url){
                    cell.pokeSprite.image = UIImage(data: data)
                }
                cell.pokeElement.loadLabel(fromURL: URL(string: pokeChosen[indexPath.row].url!)!)
                //print(pokeChosen[indexPath.row].url!)
//                fetchPokeData(pokeDataLink: pokeChosen[indexPath.row].url!)
//                cell.pokeElement.text = pokemonElementType
                
                
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCellid", for: indexPath) as! LoadingCell
                cell.activityIndicator.startAnimating()
                return cell
            }
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 100
            } else {
                return 55
            }
        }
    
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading && self.pokeChosen.count <= 150{
                loadMoreData()
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        segueIndex = indexPath.row
        self.performSegue(withIdentifier: "pokeSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pokeSegue"){
            let destinationVc = segue.destination as! PokeDetailViewController
            destinationVc.pokeSelectedURL = pokeChosen[segueIndex].url!
            
            
            
        }
        
    }
    
    func loadMoreData() {
            if !self.isLoading {
                self.isLoading = true
                DispatchQueue.global().async {
                    
                    sleep(5)
                    
                    if (self.pokeChosen.count + 30 <= 150){
                        self.pokeOffset = self.pokeChosen.count
                        self.fetchPokedex(pokemonOffset: self.pokeOffset, pokemonLoads: self.pokeLoads)
                    }
                    else if (self.pokeChosen.count == 150){
                        self.pokeOffset = self.pokeChosen.count
                        self.fetchPokedex(pokemonOffset: 150 , pokemonLoads: 1)
                        self.isLoading = false
                    }
                    else{
                        self.isLoading = false
                        //print(self.pokeChosen.count)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.isLoading = false
                    }
                }
            }
        }
    
}


