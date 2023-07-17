//
//  HomePageViewControllerTests.swift
//  OMDBFilmTests
//
//  Created by Emin Çelikkan on 16.07.2023.
//

import XCTest
@testable import OMDBFilm

final class HomePageViewControllerTests: XCTestCase {
    
    var viewController: HomePageViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        viewController = homeViewController
        viewController.loadView()
        viewController.viewDidLoad()
    }
    
    func testSetupUI() {
        //Given
        viewController.viewDidLoad()
        //Then
        XCTAssertTrue(viewController.textFieldStackView.isHidden)
        XCTAssertTrue(viewController.tableView.isHidden)
    }
    
    func testUIWhenSearchButtonClicked() {
        //Given
        viewController.viewDidLoad()
        //When
        viewController.searchFilm(viewController.searchButton ?? UIButton())
        //Then
        XCTAssertFalse(viewController.textFieldStackView.isHidden)
    }
    
    func testTableViewCell() {
        viewController.displayFilms(viewModel: createDummyTestData(imdbRating: "5.2", metascore: "71"))
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as?
        FilmsTableViewCell
        XCTAssertEqual(cell?.metaScoreLabel.textColor, UIColor.green)
        XCTAssertEqual(cell?.imdbRatingLabel.textColor, UIColor.orange)
        XCTAssertEqual(cell?.directorLabel.text, "testDirector")
    }
    
    func testDisplayLoader() {
        XCTAssertTrue(viewController.animationView?.isHidden ?? false)
        viewController.displayFilms(viewModel: createDummyTestData(imdbRating: "test", metascore: "test"))
        viewController.searchTextField.text = "Titanic"
        XCTAssertTrue(viewController.animationView?.isHidden ?? false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self else { return }
            XCTAssertFalse(viewController.animationView?.isHidden ?? false)
        }
        
    }
    
    private func createDummyTestData(imdbRating: String, metascore: String) -> HomePage.ViewModel.FilmViewModel {
        return HomePage.ViewModel.FilmViewModel(title: "test", year: "test", rated: "test", released: "test", genre: "test", director: "testDirector", ratings: [Rating](), type: "test", poster: "test", imdbRating: imdbRating, metaScore: metascore, plot: "test", revenue: "test", awards: "test", actors: "test", language: "test", country: "test"
        )
    }
}
