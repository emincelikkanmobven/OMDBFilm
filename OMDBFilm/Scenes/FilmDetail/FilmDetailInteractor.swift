//
//  FilmDetailInteractor.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import Foundation
import FirebaseAnalytics
import Alamofire
import AlamofireImage

protocol FilmDetailBusinessLogic: AnyObject {
    func firebaseFilmDetailLog()
    func getFilmDetails()
}

protocol FilmDetailDataStore: AnyObject {
    var selectedFilmModel: HomePage.ViewModel.FilmViewModel? { get set }

}

final class FilmDetailInteractor: FilmDetailBusinessLogic, FilmDetailDataStore {
    var selectedFilmModel: HomePage.ViewModel.FilmViewModel?
    var presenter: FilmDetailPresentationLogic?
    var worker: FilmDetailWorkingLogic = FilmDetailWorker()
    
    func getFilmDetails() {
        guard let filmImageUrl = selectedFilmModel?.poster else { return }
        getFilmImage(from: filmImageUrl) { [weak self] image in
            guard let self else { return }
            if let image = image {
                self.presenter?.presentFilmDetailImage(image)
            } else {
                self.presenter?.presentErrorWithMessage("Film Görselleri İndirilirken Hata Oluştu.")
            }
        }
        presenter?.presentFilmDetails(viewModel: FilmDetail.ViewModel(viewModel: selectedFilmModel))
    }
    
    func getFilmImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Image download error: \(error)")
                completion(nil)
            }
        }
    }
    
    func firebaseFilmDetailLog() {
        guard let filmTitle = selectedFilmModel?.title, let filmRating = selectedFilmModel?.imdbRating else { return }
         let logDesctription = "\(filmTitle) (\(filmRating)) detail showed to the user"
        Analytics.logEvent("film_detail", parameters: [
          "filmName": filmTitle,
          "description": logDesctription,
        ])
    }
}
