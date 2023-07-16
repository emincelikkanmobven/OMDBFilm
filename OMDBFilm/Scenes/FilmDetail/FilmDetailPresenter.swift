//
//  FilmDetailPresenter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import Foundation

protocol FilmDetailPresentationLogic: AnyObject {
    
}

final class FilmDetailPresenter: FilmDetailPresentationLogic {
    
    weak var viewController: FilmDetailDisplayLogic?
    
}
