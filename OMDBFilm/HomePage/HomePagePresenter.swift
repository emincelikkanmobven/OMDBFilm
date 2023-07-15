//
//  HomePagePresenter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation

protocol HomePagePresentationLogic: AnyObject {
    func presentLoader(hide: Bool)
}

final class HomePagePresenter: HomePagePresentationLogic {
    
    weak var viewController: HomePageDisplayLogic?
    
    func presentLoader(hide: Bool) {
        viewController?.displayLoader(hide: hide)
    }
}
