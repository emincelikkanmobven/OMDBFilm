//
//  FilmDetailPresenter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import Foundation
import UIKit

protocol FilmDetailPresentationLogic: AnyObject {
    func presentFilmDetails(viewModel: FilmDetail.ViewModel)
    func presentFilmDetailImage(_ withImage: UIImage)
    func presentErrorWithMessage(_ message: String)
}

final class FilmDetailPresenter: FilmDetailPresentationLogic {
    
    weak var viewController: FilmDetailDisplayLogic?
    
    func presentErrorWithMessage(_ message: String) {
        viewController?.displayErrorWithMessage(message)
    }
    
    func presentFilmDetailImage(_ withImage: UIImage) {
        viewController?.displayFilmImage(withImage)
    }
    
    func presentFilmDetails(viewModel: FilmDetail.ViewModel) {
        viewController?.displayFilmDetails(viewModel: viewModel)
    }
}
