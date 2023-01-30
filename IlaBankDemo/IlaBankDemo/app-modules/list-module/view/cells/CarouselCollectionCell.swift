//
//  CarouselCollectionCell.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import UIKit

class CarouselCollectionCell: UICollectionViewCell, ReusableProtocol {

    @IBOutlet weak var courosalImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    // MARK: - Configure Cell-
    func configureCell(imageUrl: String)  {
        if let image = UIImage(named: imageUrl){
            courosalImageView.image = image
        }
    }
}
