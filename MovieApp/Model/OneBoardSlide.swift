//
//  OneBoardSlide.swift
//  MovieApp
//
//  Created by AsherFelix on 07/10/2023.
//

import Foundation
import UIKit
struct OnBoardSlide {
    var image: String
    var titel: String
    var description: String
    static var onBoard: [OnBoardSlide] = [OnBoardSlide(image: "onBoard1", titel: "Discover Exciting Films", description: "Welcome to our film app! Explore a world of exciting movies, from blockbusters to indie gems"),OnBoardSlide(image: "onBoard2", titel: "Watch Anywhere", description: "Our app provides personalized film recommendations based on your preferences. Enjoy tailored suggestions for your movie nights."),OnBoardSlide(image: "onBoard3", titel: "Stay Updated", description: "Stay updated with the latest releases and film news. Never miss out on the hottest movies and entertainment updates.")]
}
