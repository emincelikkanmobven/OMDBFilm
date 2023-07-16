//
//  FilmDetailInteractor.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import Foundation
import FirebaseAnalytics

protocol FilmDetailBusinessLogic: AnyObject {
    func firebaseFilmDetailLog()
}

protocol FilmDetailDataStore: AnyObject {
    var viewModel: HomePage.ViewModel.FilmViewModel? { get set }

}

final class FilmDetailInteractor: FilmDetailBusinessLogic, FilmDetailDataStore {
    var viewModel: HomePage.ViewModel.FilmViewModel?
    var presenter: FilmDetailPresentationLogic?
    var worker: FilmDetailWorkingLogic = FilmDetailWorker()
    
    func firebaseFilmDetailLog() {
        guard let filmTitle = viewModel?.title, let filmRating = viewModel?.imdbRating else { return }
         let logDesctription = "\(filmTitle) (\(filmRating)) detail showed to the user"
        Analytics.logEvent("film_detail", parameters: [
          "filmName": filmTitle,
          "description": logDesctription,
        ])
    }
}
