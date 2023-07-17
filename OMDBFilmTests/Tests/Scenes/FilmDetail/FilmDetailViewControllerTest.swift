//
//  FilmDetailViewControllerTest.swift
//  OMDBFilmTests
//
//  Created by Emin Çelikkan on 17.07.2023.
//

import XCTest
@testable import OMDBFilm

final class FilmDetailViewControllerTest: XCTestCase {

    var viewController: FilmDetailViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "FilmDetail", bundle: nil)
        let filmDetailViewController = storyboard.instantiateViewController(withIdentifier: "FilmDetailViewController") as! FilmDetailViewController
        viewController = filmDetailViewController
        viewController.loadView()
        viewController.viewDidLoad()
    }

    func testTabState() {
        //Given
        XCTAssertEqual(viewController.currentTabState, .detail)
        //When
        viewController.showActors(viewController.actorsButton ?? UIButton())
        //Then
        XCTAssertEqual(viewController.currentTabState, .actors)
    }
    
    func testSetupUI() {
        XCTAssertEqual(viewController.ratingView.layer.borderColor, UIColor.systemCyan.cgColor)
        XCTAssertEqual(viewController.languagesButton.layer.cornerRadius, 8)
    }
    
    func testHandleTabUI() {
        //When
        viewController.showLanguages(viewController.languagesButton ?? UIButton())
        //Then
        XCTAssertTrue(viewController.languagesButton.isSelected)
        XCTAssertEqual(viewController.languagesButton.backgroundColor, UIColor.systemCyan)
        XCTAssertFalse(viewController.actorsButton.isSelected)
        XCTAssertFalse(viewController.detailButton.isSelected)
        XCTAssertEqual(viewController.detailButton.backgroundColor, UIColor.clear)
        
        viewController.showDetail(viewController.detailButton ?? UIButton())
        XCTAssertTrue(viewController.detailButton.isSelected)
        XCTAssertFalse(viewController.languagesButton.isSelected)
        XCTAssertEqual(viewController.languagesButton.backgroundColor, UIColor.clear)
        XCTAssertFalse(viewController.actorsButton.isSelected)
    }
    
    func testHandleRatingLabelUI() {
        viewController.displayFilmDetails(viewModel: FilmDetail.ViewModel(viewModel: HomePage.ViewModel.FilmViewModel(title: "test", year: "test", rated: "test", released: "test", genre: "test", director: "test", ratings:  [Rating](), type: "test", poster: "test", imdbRating: "3.2", metaScore: "65", plot: "test", revenue: "test", awards: "test", actors: "test", language: "test", country: "test")))
        XCTAssertEqual(viewController.imdbRatingLabel.text, "3.2")
        XCTAssertEqual(viewController.imdbRatingLabel.textColor, .red)
        XCTAssertEqual(viewController.metaScoreRatingLabel.text, "65")
        XCTAssertEqual(viewController.metaScoreRatingLabel.textColor, .orange)
    }
}
