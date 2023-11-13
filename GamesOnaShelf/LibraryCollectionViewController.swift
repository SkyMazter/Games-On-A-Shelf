//
//  HomeCollectionViewController.swift
//  GamesOnaShelf
//
//  Created by Oscar Comunidad on 10/26/23.
//

import UIKit

//class SearchResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    let mytableView = UITableView(frame: .zero, style: .plain)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(mytableView) // 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "result")
//        cell.textLabel!.text = "Placeholder"
//        return cell
//    }
//    
//
//}


class LibraryCollectionViewController: UICollectionViewController,  UISearchResultsUpdating, UISearchBarDelegate{
    let searchController = UISearchController(searchResultsController:nil)
    let button = UIBarButtonItem()
    let dataSource: [String] = []
    var filtered: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        collectionView.delegate = self
        
        filtered = dataSource
        
        navigationItem.setRightBarButton(button, animated: true)
        
        
        }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text  = searchController.searchBar.text?.lowercased() else{
            return
        }
        filterCurrentDataSource(searchTerm: text)
        print(text)
        
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        if let text = searchBar.text{
            filterCurrentDataSource(searchTerm: text)
        }

        print("searched")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        restoreCurrentDataSource()
        print("canceled")
    }
    func filterCurrentDataSource(searchTerm: String){
        if searchTerm.count > 0 {
            filtered = dataSource
            let results = filtered.filter {$0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased() )}
            filtered = results
            print(results)
            collectionView.reloadData()
        }
    }
    
    func restoreCurrentDataSource(){
        filtered = dataSource
        collectionView.reloadData()
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
//        if(dataSource.count == 0){
//            return 1
//        }else{
//            return dataSource.count
//        }
        return filtered.count
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
            
            if(filtered.count ==  0){
                gameCell.configure(with: "Add New")
                cell = gameCell
            }
            else{
                gameCell.configure(with: filtered[indexPath.row])
                cell = gameCell
            }
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
       
        if(filtered.count ==  0){
            let gameDetails = GameDetailsViewController(gameName: "Add New")
            navigationController?.pushViewController(gameDetails, animated: true)
        }
        else{
            let filteredName = filtered[indexPath.row]
            let gameDetails = GameDetailsViewController(gameName: filteredName)
            navigationController?.pushViewController(gameDetails, animated: true)
        }
        
    }



}
