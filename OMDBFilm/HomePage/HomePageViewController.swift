//
//  HomePageViewController.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import UIKit

protocol HomePageDisplayLogic: AnyObject {
    
}

final class HomePageViewController: UIViewController {
    
    var interactor: HomePageBusinessLogic?
    var router: (HomePageRoutingLogic & HomePageDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomePageInteractor()
        let presenter = HomePagePresenter()
        let router = HomePageRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension HomePageViewController: HomePageDisplayLogic {
    
}
