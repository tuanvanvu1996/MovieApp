//
//  HomeViewController.swift
//  MovieApp
//
//  Created by AsherFelix on 12/10/2023.
//

import UIKit
import Alamofire
import Kingfisher
struct TitleViewModel {
    let titleName: String
    let posterURL: String
}
class HomeViewController: UIViewController {
    //    private var randomTrendingMovie: Title?
    @IBOutlet weak var homeTableView: UITableView!
    enum HomeSections: Int {
        case headerMoview = 0
        case trendingMovies = 1
        case trendingTv = 2
        case popular = 3
        case upcoming = 4
        case topRated = 5
    }
    private var section = [HomeSections]()
    private var headerHome = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        section = [HomeSections.headerMoview, HomeSections.trendingMovies, HomeSections.trendingTv, HomeSections.popular, HomeSections.upcoming, HomeSections.topRated]
        setupTableView()
        callApi()
        
    }
    private func setupTableView() {
        homeTableView.dataSource = self
        homeTableView.delegate = self
        let headerCell = UINib(nibName: "HeaderHomeTableViewCell", bundle: nil)
        homeTableView.register(headerCell, forCellReuseIdentifier: "HeaderHomeTableViewCell")
        let trendingHeader = UINib(nibName: "TrendingHeaderTableViewCell", bundle: nil)
        homeTableView.register(trendingHeader, forCellReuseIdentifier: "TrendingHeaderTableViewCell")
        let trending = UINib(nibName: "TrendingTableViewCell", bundle: nil)
        homeTableView.register(trending, forCellReuseIdentifier: "TrendingTableViewCell")
        
    }
    private func callApi() {
        let apiKey = "b11178c07ba517d41d162f0aefa2edfc" // Replace with your actual API key
        let apiUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1"
        AF.request(apiUrl,method: .get,
                   parameters: ["page": 1],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: [
                    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMTExNzhjMDdiYTUxN2Q0MWQxNjJmMGFlZmEyZWRmYyIsInN1YiI6IjY0ZjFjY2UyNWYyYjhkMDBjNDMyMzc3YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1BHamevvFKiKyJpH9rz9I78eApq0ydDhNTL5dANGfxk"
                    
                    
                   ])
        .validate(statusCode: 200..<299)
        .responseDecodable(of: NewResponse.self) { (afDataResponse) in
            switch afDataResponse.result {
            case .success(let data):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.headerHome = data.results
                    self.homeTableView.reloadData()
                }
                break
            case .failure(let err):
                print(err.errorDescription)
                break
            }
        }
    }
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let trendingMoviesHeader = tableView.dequeueReusableCell(withIdentifier: "TrendingHeaderTableViewCell") as! TrendingHeaderTableViewCell
////                trendingMoviesHeader.
//            return trendingMoviesHeader
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerHome.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderHomeTableViewCell") as! HeaderHomeTableViewCell
        cell.binData(data: headerHome[indexPath.row])
        return cell
    }
    
    
}
