//
//  TextCollectionViewCell.swift
//  EasyChooser1
//
//  Created by Kamil Gucik on 09/04/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import UIKit

protocol TextCellDelegate:class {
    func delete(cell: TextCollectionViewCell)
}

class TextCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var count = 1
    
    func configure(with name : String) {
        if count == 1 {
            if let text = label {
            text.text = name
            closeBB.isHidden = !isEditing
            count += 1
            }
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    weak var delegate: TextCellDelegate?
    
    var isEditing: Bool = false {
        didSet {
            closeBB.isHidden = !isEditing
        }
    }
    
    @IBOutlet weak var closeBB: UIButton! {
        didSet {
            closeBB.tintColor = .black
            closeBB.layer.cornerRadius = closeBB.bounds.width / 2.0
            closeBB.layer.masksToBounds = true
            closeBB.isHidden = isEditing
            
            }
        }
    }


