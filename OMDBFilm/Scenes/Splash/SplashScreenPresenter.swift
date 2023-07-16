//
//  SplashScreenPresenter.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation

protocol SplashScreenPresentationLogic: AnyObject {
    func presentErrorWithMessage(_  message: String)
    func presentHomePage()
    func presentConfigText(_ text: String)
}

final class SplashScreenPresenter: SplashScreenPresentationLogic {
  
    weak var viewController: SplashScreenDisplayLogic?
    
    func presentErrorWithMessage(_ message: String) {
        viewController?.displayErrorWithMessage(message)
    }
    
    func presentHomePage() {
        viewController?.displayHomePage()
    }
    
    func presentConfigText(_ text: String) {
        viewController?.displayConfigText(text)
    }

    
}
