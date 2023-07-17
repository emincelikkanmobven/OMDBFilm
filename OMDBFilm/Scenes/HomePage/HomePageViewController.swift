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
    @IBOutlet var textFieldStackView: UIStackView!
    var interactor: HomePageBusinessLogic?
    var router: (HomePageRoutingLogic & HomePageDataPassing)?
    var viewModel: HomePage.ViewModel.FilmViewModel?
    var searchTimer: Timer?
    var filmList: [HomePage.ViewModel.FilmViewModel]? = []
    var animationView: LottieAnimationView?
    
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
        searchTextField.delegate = self
        registerTableViewCells()
        setupUI()
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
    
    private func setupUI() {
        animationView = LottieAnimationView(name: "popcornAnimation")
        animationView?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView?.center = view.center
        animationView?.loopMode = .loop
        animationView?.isHidden = true
        tableView.isHidden = true
        textFieldStackView.isHidden = true
    }
    
    private func registerTableViewCells() {
        let filmsCell = UINib(nibName: "FilmsTableViewCell",
                              bundle: nil)
        self.tableView.register(filmsCell,
                                forCellReuseIdentifier: "FilmsTableViewCell")
    }
    
    @IBAction func searchFilm(_ sender: Any) {
        textFieldStackView.isHidden = false
    }
}
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filmCell = tableView.dequeueReusableCell(withIdentifier: "FilmsTableViewCell", for: indexPath) as? FilmsTableViewCell ?? FilmsTableViewCell(style: .default, reuseIdentifier: "FilmsTableViewCell")
        filmCell.selectionStyle = .none
        filmCell.viewModel = filmList?[indexPath.row]
        filmCell.setUpCell()
        return filmCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        guard let viewModel = filmList?[indexPath.row] else { return }
        router?.routeToFilmDetails(viewModel: viewModel)
    }
}

extension HomePageViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchTimer?.invalidate()
        if isTextValidForSearch() {
            
            searchTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
                self?.interactor?.searchFilm(withText: self?.searchTextField.text ?? "" )
            }
        }
    }
    
    private func isTextValidForSearch() -> Bool {
        return searchTextField.text?.count ?? 0 > 3
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return searchTextField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension HomePageViewController: HomePageDisplayLogic {
    func displayErrorWithMessage(_ message: String) {
        let alertController = UIAlertController(title: "Sonuç Bulunamadı.", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
        
    }
    
    func displayFilms(viewModel: HomePage.ViewModel.FilmViewModel) {
        //// Since the API Service doesn't gives any list response, app is designed
        //// to be able to add every single response to the film list and show
        //// in the Table View
        self.filmList?.insert(viewModel, at: 0)
        tableView.isHidden = false
        tableView.reloadData()
        displayLoader(hide: true)
    }
    
    
    
    func displayLoader(hide: Bool) {
        isAnimationVisible(!hide)
    }
    
    private func isAnimationVisible(_ isVisible: Bool) {
       
        view.addSubview(animationView ?? LottieAnimationView(animation: .none))
            if isVisible {
                view.isUserInteractionEnabled = !isVisible
                animationView?.play()
                animationView?.isHidden = !isVisible

            } else {
                view.isUserInteractionEnabled = !isVisible
                animationView?.stop()
                animationView?.isHidden = !isVisible
            }
    }
}
