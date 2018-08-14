//
//  TableViewCell.swift
//  NodeAds
//
//  Created by Polina on 8/11/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import UIKit
import WebKit

protocol TableViewCellDelegate: class {
    func openPDF(at index: IndexPath)
}

class TableViewCell: UITableViewCell, WKNavigationDelegate {

    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var placeOfWorkLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var indexPath: IndexPath!
    weak var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with personData: Info?) {
        
        if let personData = personData {
            firstnameLabel.text = personData.firstname
            lastnameLabel.text = personData.lastname
            
            if let placeOfWork = personData.placeOfWork {
                placeOfWorkLabel.text = placeOfWork
            }
            
            if  personData.position != nil && personData.position != "ні" && (personData.position?.isEmpty)! {
                placeOfWorkLabel.text = personData.position
            }
        }
    }
    
    private func addToFavorite() {}
    private func removeFromFavorite() {}
    
    @IBAction func linkButton(_ sender: AnyObject) {
        self.delegate?.openPDF(at: indexPath)
    }
    
    @IBAction func addToFavoriteButton(_ sender: Any) {
        
        switch  favoriteButton.currentImage{
        case UIImage(named: "filledStar") :
            favoriteButton.setImage(UIImage(named: "emptyStar"), for: .normal)
        case UIImage(named: "emptyStar") :
            favoriteButton.setImage(UIImage(named: "filledStar"), for: .normal)
        default: print("error: can't add to favorite")
        }
        
    }
    
}
