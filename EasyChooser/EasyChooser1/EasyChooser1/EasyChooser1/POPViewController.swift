//
//  POPViewController.swift
//  EasyChooser1
//
//  Created by Kamil Gucik on 12/04/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import UIKit

class POPViewController: UIViewController {

    var finalText = ""
    
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        winnerLabel.text = finalText
    }
}
