//
//  TrendingTableViewCell.swift
//  MovieApp
//
//  Created by AsherFelix on 12/10/2023.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    private var imageTrending = [String]()
    @IBOutlet weak var trendingCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    private func setupCollectionView() {
        if let flowLayout = trendingCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 10
        }
        trendingCollection.showsHorizontalScrollIndicator = false
        let colectionCell = UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
        trendingCollection.register(colectionCell, forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        trendingCollection.dataSource = self
        trendingCollection.delegate = self
        
    }
}
extension TrendingTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageTrending.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath)
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let image = imageTrending[indexPath.row]
//        
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
}
