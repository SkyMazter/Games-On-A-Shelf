//
//  CollectionViewCell.swift
//  GamesOnaShelf
//
//  Created by Oscar Comunidad on 10/28/23.
//

import UIKit

class GameCell: UICollectionViewCell {
    @IBOutlet var Customlable: UILabel!
    
    func configure(with GameTitle: String){
        Customlable.text = GameTitle
    }
    func returnName() -> String?{
        return Customlable.text
    }
}
