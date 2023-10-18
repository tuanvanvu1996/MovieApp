//
//  OnBoardCollectionViewCell.swift
//  MovieApp
//
//  Created by AsherFelix on 07/10/2023.
//

import UIKit

class OnBoardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var onBoardImage: UIImageView!
    func configue(image: UIImage) {
        onBoardImage.image = image
    }
}
