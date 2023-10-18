//
//  TrendingCollectionViewCell.swift
//  MovieApp
//
//  Created by AsherFelix on 12/10/2023.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trendingImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func binData(image: UIImage) {
        trendingImage.image = image
    }

}
