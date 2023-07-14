//
//  SplashScreenRouter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation
import UIKit

protocol SplashScreenRoutingLogic: AnyObject {
    func routeToHomePage()
}

protocol SplashScreenDataPassing: SplashScreenWorkingLogic {
    var dataStore: SplashScreenDataStore? { get }
}

final class SplashScreenRouter: SplashScreenRoutingLogic, SplashScreenDataPassing {
    
    weak var viewController: SplashScreenViewController?
    var dataStore: SplashScreenDataStore?
    
    func routeToHomePage() {
        let homePage = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "HomePageViewController")
        homePage.modalPresentationStyle = .overFullScreen
        viewController?.present(homePage, animated: true)
    }
    
}
