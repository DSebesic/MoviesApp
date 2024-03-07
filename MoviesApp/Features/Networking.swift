//
//  Networking.swift
//  MoviesApp
//
//  Created by Flabbergast on 05.03.2024..
//

import Foundation

protocol Networking {
    func fetchMovies() async -> [Movie]
}
//
//class LiveNetworking: Networking {
//    func fetchMovies() async -> [Movie] {
//        <#code#>
//    }
//}
