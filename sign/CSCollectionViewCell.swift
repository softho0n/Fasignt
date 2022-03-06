//
//  CSCollectionViewCell.swift
//  sign
//
//  Created by Jason on 2022/02/21.
//

import UIKit

class CSCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor(red: 244.4 / 255.0, green: 245.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
                layer.borderColor = UIColor.tintColor.cgColor
            }
            else {
                backgroundColor = UIColor.white
                layer.borderColor = UIColor.black.cgColor
            }
        }
    }
}
