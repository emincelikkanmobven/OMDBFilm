//
//  HomePageModels.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation

// swiftlint:disable nesting
enum HomePage {

        struct Request {
            
        }
        
        struct Response {
            var response: FilmResponse?
        }
        
        struct ViewModel {
             struct FilmViewModel {
                var title: String?
                var year: String?
                var rated: String?
                var released: String?
                var genre: String?
                var director: String?
                var ratings: [Rating]?
                var type: String?
                var poster: String?
                var imdbRating: String?
                var metaScore: String?
                var plot: String?
                var revenue: String?
            }
        }
        
    
    
}
// swiftlint:enable nesting
