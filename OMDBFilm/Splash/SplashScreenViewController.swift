//
//  SplashScreenViewController.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import UIKit

protocol SplashScreenDisplayLogic: AnyObject {
    func displayHomePage()
    func displayErrorWithMessage(_ message: String)
}

final class SplashScreenViewController: UIViewController {
    
    var interactor: SplashScreenBusinessLogic?
    var router: (SplashScreenRoutingLogic & SplashScreenDataPassing)?

    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.checkConnectionStatus()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SplashScreenInteractor()
        let presenter = SplashScreenPresenter()
        let router = SplashScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
}

extension SplashScreenViewController: SplashScreenDisplayLogic {
    func displayErrorWithMessage(_ message: String) {
        //TODO: This will changed to the Alert
        print("Error Occured")
    }
    
    func displayHomePage() {
        router?.routeToHomePage()
    }
}
