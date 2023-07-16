//
//  FilmDetailRouter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import Foundation

protocol FilmDetailRoutingLogic: AnyObject {
    
}

protocol FilmDetailDataPassing: AnyObject {
    var dataStore: FilmDetailDataStore? { get }

}

final class FilmDetailRouter: FilmDetailRoutingLogic, FilmDetailDataPassing {
    weak var viewController: FilmDetailViewController?
    var dataStore: FilmDetailDataStore?
    
}
