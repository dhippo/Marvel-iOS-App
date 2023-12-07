//
//  DetailViewController.swift
//  trainingApp
//
//  Created by MacBook on 17/11/2023.
//

import Foundation

import UIKit

//ici : on voit que la classe parente est UIViewController et que le protocole est UITableViewDataSource
class DetailViewController: UIViewController, UITableViewDataSource {
 
    @IBOutlet var list:UITableView?
    
    private var viewModel = DetailViewModel()

    var marvelArray = [Marvel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getMarvels { [weak self] marvels in
            self?.marvelArray = marvels
            self?.list?.reloadData()
        }
        
        list?.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let marvel = marvelArray[indexPath.row]
        cell.textLabel?.text = marvel.name
        cell.detailTextLabel?.text = marvel.description

        // Réinitialiser l'image précédente
        cell.imageView?.image = nil

        // Télécharger et afficher l'image
        if let imageURL = marvel.imageURL {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                        cell.setNeedsLayout() // Ceci est nécessaire pour mettre à jour la cellule avec l'image
                    }
                }
            }.resume()
        }
        
        return cell
    }

}

