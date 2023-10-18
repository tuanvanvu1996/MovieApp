import Foundation
import UIKit
import Alamofire

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Float?
    let voteCount: Int?
}

struct NewResponse: Codable {
    let dates: Dates
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

struct Dates: Codable {
    let maximum: String
    let minimum: String
}


