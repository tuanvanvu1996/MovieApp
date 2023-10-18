//
//  TrendingHeaderTableViewCell.swift
//  MovieApp
//
//  Created by AsherFelix on 12/10/2023.
//

import UIKit

class TrendingHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trendingMovieHeader: UILabel!
    private var seeallCallback: (() -> Void)!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        seeallCallback()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    private func binData(titel: String, seeallCallback: @escaping (() -> Void)) {
        trendingMovieHeader.text = titel
        self.seeallCallback = seeallCallback
    }
    
}
