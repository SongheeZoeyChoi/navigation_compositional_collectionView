//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by Songhee Choi on 2022/07/07.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
