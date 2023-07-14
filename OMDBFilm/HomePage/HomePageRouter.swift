//
//  HomePageRouter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation

protocol HomePageRoutingLogic: AnyObject {
    
}

protocol HomePageDataPassing: class {
    var dataStore: HomePageDataStore? { get }
}

final class HomePageRouter: HomePageRoutingLogic, HomePageDataPassing {
    
    weak var viewController: HomePageViewController?
    var dataStore: HomePageDataStore?
    
}
