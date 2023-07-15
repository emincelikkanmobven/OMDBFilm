//
//  FilmResponse.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//


import Foundation

// MARK: - FilmResponse
public struct FilmResponse: Codable {
    public var title: String?
    public var year: String?
    public var rated: String?
    public var released: String?
    public var runtime: String?
    public var genre: String?
    public var director: String?
    public var writer: String?
    public var actors: String?
    public var plot: String?
    public var language: String?
    public var country: String?
    public var awards: String?
    public var poster: String?
    public var ratings: [Rating]?
    public var metascore: String?
    public var imdbRating: String?
    public var imdbVotes: String?
    public var imdbID: String?
    public var type: String?
    public var dvd: String?
    public var boxOffice: String?
    public var production: String?
    public var website, response: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

// MARK: - Rating
public struct Rating: Codable {
   public var source, value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
