//
//  HomeCollectionViewController.swift
//  GamesOnaShelf
//
//  Created by Oscar Comunidad on 10/26/23.
//

import UIKit

class SearchResultsVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
    }
}


class HomeCollectionViewController: UICollectionViewController,  UISearchResultsUpdating{
    
    let searchController = UISearchController(searchResultsController: SearchResultsVC())
    let dataSource: [String] = ["Genshin Impact","Minecraft", "Fortnite", "COD", "Counter Strike Golbal Offensive"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        view.backgroundColor = .lightGray
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "GameCell")

        // Do any additional setup after loading the view.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let resultsPage = searchController.searchResultsController as? SearchResultsVC
        guard let text = searchController.searchBar.text else{
            return
        }
        
        resultsPage?.view.backgroundColor = .white
        print(text)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 10
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSource.count
    }

//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//    
//        // Configure the cell
//        cell.backgroundColor = .yellow
//        //cell.layoutMargins = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
//        
//    
//        return cell
//    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as? GameCell {
            gameCell.configure(with: dataSource[indexPath.row])
            cell = gameCell
            //cell.backgroundColor = .systemRed
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    //highlights a cell
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at:  indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.green.cgColor
        UIView.animate(withDuration: 0.3) { // for animation effect
            cell?.backgroundColor = UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 1.0)
        }
        return true
    }
    
    
    /*
     Example of how to switch to another view controller:
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let country = countries[indexPath.row]
         
         let detailsViewController = CountryDetailsViewController(countryName: country.name.common)
         navigationController?.pushViewController(detailsViewController, animated: true)
     }
     
     */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let game = collectionView.cellForItem(at: indexPath)
        let gameDetails = GameDetailsViewController(gameName: dataSource[indexPath.row])
        navigationController?.pushViewController(gameDetails, animated: true)
        
    }

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    



}
