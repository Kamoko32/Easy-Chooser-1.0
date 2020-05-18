//
//  popPhotoViewController.swift
//  EasyChooser1
//
//  Created by Kamil Gucik on 15/04/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import UIKit

class popPhotoViewController: UIViewController {

    var image: UIImage?
    
    @IBOutlet weak var photoWinner: UIImageView!
    
    override func viewDidLoad() {
        photoWinner.image = image
    }

}
