//
//  HeaderHomeTableViewCell.swift
//  MovieApp
//
//  Created by AsherFelix on 12/10/2023.
//

import UIKit

class HeaderHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var headerView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func binData(data:Movie) {
        headerView.image = UIImage(named: data.backdropPath ?? "onBoard2")
        //        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath)") else {
        //            return
        //        }
        //        let session = URLSession.shared
        //        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
        //            if let error = error {
        //                print("Error loading image: \(error)")
        //                return
        //            }
        //
        //            if let data = data {
        //                // Thử tạo một UIImage từ dữ liệu
        //                if let image = UIImage(data: data) {
        //                    // Cập nhật giao diện của bạn với hình ảnh
        //                    DispatchQueue.main.async {
        //                        self?.headerView.image = image
        //                    }
        //                } else {
        //                    print("Lỗi khi tạo UIImage từ dữ liệu")
        //                }
        //            } else {
        //                print("Không có dữ liệu nhận được từ URL")
        //            }
        //
        //        }
        //
        //        dataTask.resume()
        //    }
        
    }
}
