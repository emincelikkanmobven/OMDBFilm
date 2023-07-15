//
//  HomePageViewController.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import UIKit
import Lottie

protocol HomePageDisplayLogic: AnyObject {
    func displayLoader(hide: Bool)
    func displayFilms(viewModel: HomePage.ViewModel.FilmViewModel)
    func displayErrorWithMessage(_ message: String)
}

final class HomePageViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    var interactor: HomePageBusinessLogic?
    var router: (HomePageRoutingLogic & HomePageDataPassing)?
    var viewModel: HomePage.ViewModel.FilmViewModel?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerTableViewCells()
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
    
    private func registerTableViewCells() {
        let filmsCell = UINib(nibName: "FilmsTableViewCell",
                                  bundle: nil)
        self.tableView.register(filmsCell,
                                forCellReuseIdentifier: "FilmsTableViewCell")
    }
    
    @IBAction func searchFilm(_ sender: Any) {
        interactor?.searchFilm(withText: searchTextField.text ?? "")
    }
}
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filmCell = tableView.dequeueReusableCell(withIdentifier: "FilmsTableViewCell", for: indexPath) as? FilmsTableViewCell ?? FilmsTableViewCell(style: .default, reuseIdentifier: "FilmsTableViewCell")
        filmCell.viewModel = viewModel
        filmCell.setUpCell()
        return filmCell
    }
}

extension HomePageViewController: HomePageDisplayLogic {
    func displayErrorWithMessage(_ message: String) {
        print(message)
    }
    
    func displayFilms(viewModel: HomePage.ViewModel.FilmViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
        displayLoader(hide: true)
    }
    
    func displayLoader(hide: Bool) {
        let animationView = LottieAnimationView(name: "popcornAnimation")
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.loopMode = .playOnce
        view.isUserInteractionEnabled = false
        view.addSubview(animationView)
        animationView.isHidden = hide
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.isUserInteractionEnabled = true
            animationView.isHidden = true
        }
        
    }
}
