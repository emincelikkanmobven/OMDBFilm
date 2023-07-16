//
//  HomePagePresenter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation

protocol HomePagePresentationLogic: AnyObject {
    func presentLoader(hide: Bool)
    func presentFilms(response: HomePage.Response)
    func presentErrorWithMessage(_ message: String)
}

final class HomePagePresenter: HomePagePresentationLogic {
    
    weak var viewController: HomePageDisplayLogic?
    
    func presentLoader(hide: Bool) {
        viewController?.displayLoader(hide: hide)
    }
    
    func presentFilms(response: HomePage.Response) {
        guard let filmResponse = response.response else {
               return
           }
           
           let filmsViewModel = HomePage.ViewModel.FilmViewModel(
            title: filmResponse.title,
            year: filmResponse.year,
            rated: filmResponse.rated,
            released: filmResponse.released,
            genre: filmResponse.genre,
            director: filmResponse.director,
            ratings: filmResponse.ratings,
            type: filmResponse.type,
            poster: filmResponse.poster,
            imdbRating: filmResponse.imdbRating,
            metaScore: filmResponse.metascore,
            plot: filmResponse.plot,
            revenue: filmResponse.boxOffice,
            awards: filmResponse.awards,
            actors: filmResponse.actors,
            language: filmResponse.language,
            country: filmResponse.country
           )
           
           viewController?.displayFilms(viewModel: filmsViewModel)
    }
    func presentErrorWithMessage(_ message: String) {
        viewController?.displayErrorWithMessage(message)
    }
}
