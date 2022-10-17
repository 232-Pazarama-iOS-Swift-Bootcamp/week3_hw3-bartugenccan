//
//  FavoritesViewController.swift
//  iTunes Client App
//
//  Created by Bartu Gençcan on 16.10.2022.
//

import UIKit
import CoreData

final class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let favoriteView = FavoriteView()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var favorites:[FavProducts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoriteView
        
        favoriteView.setLayout()
        
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
        favoriteView.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = favorites[indexPath.row].trackName as String?
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = favorites[indexPath.row]
            context.delete(commit)
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try context.save()
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetch(){
        let request = NSFetchRequest<FavProducts>(entityName: "FavProducts")
        request.returnsObjectsAsFaults = false
        
        do {
            favorites = try context.fetch(request)
            
        }catch {
            print(error.localizedDescription)
        }
    }

}
