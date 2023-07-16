//
//  HomePageRouter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation
import UIKit

protocol HomePageRoutingLogic: AnyObject {
    func routeToFilmDetails(viewModel: HomePage.ViewModel.FilmViewModel)
}

protocol HomePageDataPassing: AnyObject {
    var dataStore: HomePageDataStore? { get }
}

final class HomePageRouter: HomePageRoutingLogic, HomePageDataPassing {
    
    weak var viewController: HomePageViewController?
    var dataStore: HomePageDataStore?
    
    func routeToFilmDetails(viewModel: HomePage.ViewModel.FilmViewModel) {
        guard let viewController = viewController else { return }
        
        let storyboard = UIStoryboard(name: "FilmDetail", bundle: nil)
        if let filmDetailViewController = storyboard.instantiateViewController(
            withIdentifier: "FilmDetailViewController"
        ) as? FilmDetailViewController {
            filmDetailViewController.router?.dataStore?.selectedFilmModel = viewModel
            viewController.present(filmDetailViewController, animated: true)
        }
        
    }
}
