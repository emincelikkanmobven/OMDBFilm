//
//  FilmDetailViewController.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import UIKit

protocol FilmDetailDisplayLogic: AnyObject {
    
}

final class FilmDetailViewController: UIViewController {
    
    var interactor: FilmDetailBusinessLogic?
    var router: (FilmDetailRoutingLogic & FilmDetailDataPassing)?
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.firebaseFilmDetailLog()
    }
    private func setup() {
        let viewController = self
        let interactor = FilmDetailInteractor()
        let presenter = FilmDetailPresenter()
        let router = FilmDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension FilmDetailViewController: FilmDetailDisplayLogic {
    
}
