//
//  FilmsTableViewCell.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 15.07.2023.
//

import UIKit

public class FilmsTableViewCell: UITableViewCell {

    @IBOutlet var filmImageView: UIImageView!
    @IBOutlet var filmTitleLabel: UILabel!
    @IBOutlet var filmTypeLabel: UILabel!
    @IBOutlet var filmDurationLabel: UILabel!
    @IBOutlet var filmDescriptionTextView: UITextView!
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
