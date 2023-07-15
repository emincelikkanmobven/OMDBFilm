//
//  HomePageInteractor.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation
import Alamofire

protocol HomePageBusinessLogic: AnyObject {
    func searchFilm(withText: String)
}

protocol HomePageDataStore: AnyObject {
    
}

final class HomePageInteractor: HomePageBusinessLogic, HomePageDataStore {
    
    var presenter: HomePagePresentationLogic?
    var worker: HomePageWorkingLogic = HomePageWorker()
    
    func searchFilm(withText: String) {
        guard let apiKey = Bundle.main.infoDictionary?["OMDBApiKey"] else { return }
        let validText = withText.replacingOccurrences(of: " ", with: "+")
        let url = "http://omdbapi.com/?apikey=\(apiKey)&t=\(validText)"
        presenter?.presentLoader(hide: false)
           AF.request(url).response { [weak self] response in
               switch response.result {
               case .success(let response):
                   print("response is : \(String(describing: response))")
                   self?.presenter?.presentFilms(
                    response: HomePage.Response(
                        response: self?.decodeFilmResponse(jsonData: response!)
                    )
                   )
               case .failure(let error):
                   self?.presenter?.presentErrorWithMessage(error.localizedDescription)
               }
           }
    }
    
    private func decodeFilmResponse(jsonData: Data) -> FilmResponse {
        do {
            let decoder = JSONDecoder()
            let filmResponse = try decoder.decode(FilmResponse.self, from: jsonData)
            print(filmResponse)
            return filmResponse
        } catch {
            self.presenter?.presentErrorWithMessage(error.localizedDescription)
        }
        return FilmResponse()
    }
}
