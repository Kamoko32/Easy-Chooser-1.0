//
//  PhotoCollectionViewCell.swift
//  EasyChooser1
//
//  Created by Kamil Gucik on 15/04/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import UIKit

protocol PhotoCollectionViewCellDelegate {
    func delete(cell: PhotoCollectionViewCell)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photoImage: UIImageView!
        
    
    
    func configure (with image: UIImage) {
        if count == 1 {
            if let photo = photoImage {
                photo.image = image
                minusButtonCol.isHidden = !isEditing
                count += 1
            }
        }
    }
    
    var delegate: PhotoCollectionViewCellDelegate?
    
    @IBAction func minusButton(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    @IBOutlet weak var minusButtonCol: UIButton! {
        didSet {
            minusButtonCol.tintColor = .black
            minusButtonCol.layer.cornerRadius = minusButtonCol.bounds.width / 2.0
            minusButtonCol.layer.masksToBounds = true
            minusButtonCol.isHidden = isEditing
        }
    }
    
    
    var isEditing: Bool = false {
        didSet {
            minusButtonCol.isHidden = !isEditing
        }
    }
    
    var count = 1
    
    
    
    
}
