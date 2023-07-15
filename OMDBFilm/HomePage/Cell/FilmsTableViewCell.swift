//
//  FilmsTableViewCell.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import UIKit
import Alamofire
import AlamofireImage

public class FilmsTableViewCell: UITableViewCell {

    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var revenueLabel: UILabel!
    @IBOutlet var metaScoreLabel: UILabel!
    @IBOutlet var imdbRatingLabel: UILabel!
    @IBOutlet var filmImageView: UIImageView!
    @IBOutlet var filmTitleLabel: UILabel!
    @IBOutlet var filmTypeLabel: UILabel!
    @IBOutlet var filmReleaseDate: UILabel!
    @IBOutlet var filmDescriptionTextView: UITextView!
    var viewModel: HomePage.ViewModel.FilmViewModel?
    public override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }

    public func setUpCell() {
        setupUI()
    }
    
    func getPosterImage(from url: URL?, to imageView: UIImageView) {
        guard let url else { return }
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        imageView.image = image
                    }
                case .failure(let error):
                    print("Image download error: \(error)")
                }
            }
        
    }
    
    private func setupUI() {
        let imdbRating = Double(viewModel?.imdbRating ?? "0.0") ?? 0.0
        let metaScore = Int(viewModel?.metaScore ?? " 0") ?? 0
        
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
        case 0..<4:
            metaScoreLabel.textColor = UIColor.red
        case 4..<7:
            metaScoreLabel.textColor = UIColor.orange
        case 7...:
            metaScoreLabel.textColor = UIColor.green
        default:
            break
        }

        self.directorLabel.text = viewModel?.director
        self.filmTypeLabel.text = viewModel?.genre
        self.filmTitleLabel.text = viewModel?.title
        self.filmDescriptionTextView.text = viewModel?.plot
        self.filmReleaseDate.text = viewModel?.released
        self.imdbRatingLabel.text = viewModel?.imdbRating != "N/A" ? viewModel?.imdbRating : "Deger Bulunamadi"
        self.metaScoreLabel.text = viewModel?.metaScore != "N/A" ? viewModel?.metaScore : "Deger Bulunamadi"
        self.revenueLabel.text = viewModel?.revenue
        if let posterURL = viewModel?.poster {
                getPosterImage(from: URL(string: posterURL), to: filmImageView)
            }
    }
}
