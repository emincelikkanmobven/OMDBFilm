//
//  HomePageInteractor.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation

protocol HomePageBusinessLogic: AnyObject {
    
}

protocol HomePageDataStore: AnyObject {
    
}

final class HomePageInteractor: HomePageBusinessLogic, HomePageDataStore {
    
    var presenter: HomePagePresentationLogic?
    var worker: HomePageWorkingLogic = HomePageWorker()
    
}
