//
//  QuickFocusCellCollectionViewCell.swift
//  HeadSpaceFocus
//
//  Created by Songhee Choi on 2022/07/07.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ quickFocus: QuickFocus) {
        thumbnailImageView.image = UIImage(named: quickFocus.imageName)
        titleLabel.text = quickFocus.title
        descriptionLabel.text = quickFocus.description
    }
    
}
