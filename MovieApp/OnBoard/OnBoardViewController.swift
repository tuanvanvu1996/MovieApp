//
//  ViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 07/10/2023.
//

import UIKit

class OnBoardViewController: UIViewController {
    let window = (UIApplication.shared.delegate as? AppDelegate)?.window
    @IBOutlet weak var onBoardCollection: UICollectionView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColection()
        setupPageControl()
        setupSkipBtn()
        onBoardCollection.delegate = self
        onBoardCollection.dataSource = self
        
    }
    private func setupColection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        onBoardCollection.backgroundColor = .systemGroupedBackground
        onBoardCollection.collectionViewLayout = layout
        onBoardCollection.isPagingEnabled = true
        onBoardCollection.showsHorizontalScrollIndicator = true
    }
    private func setupPageControl() {
        pageControl.numberOfPages = OnBoardSlide.onBoard.count
    }
    private func showCaption(atIndex index: Int) {
        let slide = OnBoardSlide.onBoard[index]
        titelLabel.text = slide.titel
        descriptionLabel.text = slide.description
    }
    private func setupSkipBtn() {
        skipBtn.layer.cornerRadius = 6
        skipBtn.layer.borderWidth = 1
        skipBtn.layer.borderColor = UIColor.white.cgColor
    }
    @IBAction func skipBtn(_ sender: Any) {
        OnboardService.shared.markOnboarded()
        let screenVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScreenViewController")
        window?.rootViewController = screenVc
        window?.makeKeyAndVisible()
        
    }
}
extension OnBoardViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnBoardSlide.onBoard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let onBoardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardCollectionViewCell", for: indexPath) as! OnBoardCollectionViewCell
        let imageName = OnBoardSlide.onBoard[indexPath.item].image
        let image = UIImage(named: imageName) ?? UIImage()
        onBoardCell.configue(image: image)
        return onBoardCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        showCaption(atIndex: index)
        pageControl.currentPage = index
    }
    
    
}
