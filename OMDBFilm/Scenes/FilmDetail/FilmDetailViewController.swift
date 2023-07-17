//
//  FilmDetailViewController.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import UIKit

protocol FilmDetailDisplayLogic: AnyObject {
    func displayFilmDetails(viewModel: FilmDetail.ViewModel)
    func displayFilmImage(_ withImage: UIImage)
    func displayErrorWithMessage(_ message: String)
}

final class FilmDetailViewController: UIViewController {
    
    @IBOutlet var metaScoreRatingLabel: UILabel!
    @IBOutlet var imdbRatingLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var ratingView: UIView!
    @IBOutlet var awardsLabel: UILabel!
    @IBOutlet var languagesButton: UIButton!
    @IBOutlet var actorsButton: UIButton!
    @IBOutlet var detailButton: UIButton!
    @IBOutlet var awardsView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var textView: UITextView!
    @IBOutlet var tabView: UIView!
    @IBOutlet var bluredImage: UIImageView!
    @IBOutlet var filmImage: UIImageView!
    
    var interactor: FilmDetailBusinessLogic?
    var router: (FilmDetailRoutingLogic & FilmDetailDataPassing)?
    var viewModel: FilmDetail.ViewModel?
    var currentTabState: TabState = .detail

    
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
        setupUI()
    }
    
    private func setupUI() {
        interactor?.getFilmDetails()
        tabView.layer.cornerRadius = 16
        detailButton.layer.cornerRadius = 8
        actorsButton.layer.cornerRadius = 8
        languagesButton.layer.cornerRadius = 8
        tabView.layer.borderWidth = 1
        tabView.layer.borderColor = UIColor.systemCyan.cgColor
        awardsView.layer.borderWidth = 1
        awardsView.layer.cornerRadius = 8
        awardsView.layer.borderColor = UIColor.systemCyan.cgColor
        ratingView.layer.borderWidth = 1
        ratingView.layer.cornerRadius = 8
        ratingView.layer.borderColor = UIColor.systemCyan.cgColor
        switchTab(to: .detail)
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
    // MARK: TabState
    enum TabState {
        case detail
        case actors
        case language
    }


    func switchTab(to newState: TabState) {
        switch newState {
        case .detail:
            detailButton.isSelected = true
            actorsButton.isSelected = false
            languagesButton.isSelected = false
        case .actors:
            detailButton.isSelected = false
            actorsButton.isSelected = true
            languagesButton.isSelected = false
        case .language:
            detailButton.isSelected = false
            actorsButton.isSelected = false
            languagesButton.isSelected = true
        }
        
        currentTabState = newState
        handleTabUI(tabButtons: [detailButton,actorsButton,languagesButton])
        handleTextView()
    }
    
    private func handleTabUI(tabButtons: [UIButton]) {
        tabButtons.forEach { button in
                if button.isSelected {
                    button.backgroundColor = UIColor.systemCyan
                    button.tintColor = UIColor.white
                    //button.setTitleColor(.white, for: .normal)
                } else {
                    button.backgroundColor = UIColor.clear
                    button.tintColor = UIColor.systemCyan
                }
            }
    }
    
    @IBAction func showDetail(_ sender: Any) {
        switchTab(to: .detail)
    }
    
    @IBAction func showActors(_ sender: Any) {
        switchTab(to: .actors)
    }
    
    @IBAction func showLanguages(_ sender: Any) {
        switchTab(to: .language)
    }
    
 
}


extension FilmDetailViewController: FilmDetailDisplayLogic {
    func displayFilmImage(_ withImage: UIImage) {
        bluredImage.image = withImage
        filmImage.image = withImage
    }
    
    func displayFilmDetails(viewModel: FilmDetail.ViewModel) {
        self.viewModel = viewModel
        handleTextView()
        awardsLabel.text = viewModel.viewModel?.awards != "N/A" ? viewModel.viewModel?.awards : "Ödül Bulunamadı"
        countryLabel.text = viewModel.viewModel?.country
        imdbRatingLabel.text = viewModel.viewModel?.imdbRating != "N/A" ? viewModel.viewModel?.imdbRating : "Değer Bulunamadı"
        metaScoreRatingLabel.text = viewModel.viewModel?.metaScore != "N/A" ? viewModel.viewModel?.metaScore : "Değer Bulunamadı"
        handleRatingLabelsUI(
            imdbRating: viewModel.viewModel?.imdbRating,
            metascoreRating: viewModel.viewModel?.metaScore
        )
    }
    
    private func handleTextView() {
        switch currentTabState {
        case .detail:
            textView.text = self.viewModel?.viewModel?.plot
        case .actors:
            textView.text = self.viewModel?.viewModel?.actors
        case .language:
            textView.text = self.viewModel?.viewModel?.language
        }
    }
    
    private func handleRatingLabelsUI(imdbRating: String?, metascoreRating: String?) {
        let imdbRating = Double(imdbRating ?? "0.0") ?? 0.0
        let metaScore = Int(metascoreRating ?? " 0") ?? 0
        
        switch imdbRating {
        case 0.0..<4.0:
            imdbRatingLabel.textColor = UIColor.red
        case 4.0..<7.0:
            imdbRatingLabel.textColor = UIColor.orange
        case 7.0...:
            imdbRatingLabel.textColor = UIColor.green
        default:
            break
        }
        
        switch metaScore {
        case 0..<40:
            metaScoreRatingLabel.textColor = UIColor.red
        case 40..<70:
            metaScoreRatingLabel.textColor = UIColor.orange
        case 70...:
            metaScoreRatingLabel.textColor = UIColor.green
        default:
            break
        }

    }
 
    
    func displayErrorWithMessage(_ message: String) {
        let alertController = UIAlertController(title: "Hata Oluştu", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}

