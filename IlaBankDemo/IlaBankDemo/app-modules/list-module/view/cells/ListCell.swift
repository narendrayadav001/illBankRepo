//
//  ListCell.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import UIKit

class ListCell: UITableViewCell,ReusableProtocol {

    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var listTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configure Cell-
    func configureCell(titleText: String, imageUrl: String)  {
        listTitle.text = titleText
        
        if let image = UIImage(named: imageUrl){
            listImageView.image = image
        }
        
    }
    
}
