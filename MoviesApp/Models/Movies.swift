//
//  Movie.swift
//  MovieApp
//
//  Created by Flabbergast on 01.03.2024..
//

import Foundation


struct Movie: Codable, Hashable, Identifiable {
    let Plot: String
    let type: String
    let Year: String
    let Genre: String
    let Rated: String
    let Title: String
    let Actors: String
    let Awards: String
    let Images: [String]
    let Poster: String
    let Writer: String
    let imdbID: String
    let Country: String
    let Runtime: String
    let Director: String
    let Language: String
    let Released: String
    let Response: String
    let Metascore: String
    let imdbVotes: String
    let imdbRating: String
    
    var id: String {
        imdbID
    }
    
    enum CodingKeys: String, CodingKey {
        case type = "Type"
        
        case Plot
        case Year
        case Genre
        case Rated
        case Title
        case Actors
        case Awards
        case Images
        case Poster
        case Writer
        case imdbID
        case Country
        case Runtime
        case Director
        case Language
        case Released
        case Response
        case Metascore
        case imdbVotes
        case imdbRating
    }
}
