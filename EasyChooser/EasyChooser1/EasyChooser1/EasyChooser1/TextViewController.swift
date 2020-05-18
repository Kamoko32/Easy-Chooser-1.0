//
//  TextViewController.swift
//  EasyChooser1
//
//  Created by Kamil Gucik on 09/04/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, TextCellDelegate, UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        texts.append(textField.text!)
        let insertedIndex = IndexPath(item: texts.count - 1, section: 0)
        textCollectionView.insertItems(at: [insertedIndex])
        
        textField.resignFirstResponder()
        textField.text = "Enter name"
        textField.alpha = 0.5
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
        textField.text = "Enter name"
        textField.alpha = 0.5
        }
    }
    
    
    //MARK:- DELEGATIN
    
    func delete(cell: TextCollectionViewCell) {
        if let pathIndex = textCollectionView.indexPath(for: cell) {
            texts.remove(at: pathIndex.row)
            textCollectionView.deleteItems(at: [pathIndex])
            cell.closeBB.isHidden = true
            if texts.isEmpty {
                isButtonEnabled = false
                viewDidLoad()
            }
        }
    }
    
    
   //MARK:- CollectionView
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            texts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let textCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Text Cell", for: indexPath) as? TextCollectionViewCell {
            textCell.configure(with: texts[indexPath.row])
            textCell.delegate = self
            cell = textCell
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let endedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Text Cell", for: indexPath) as? TextCollectionViewCell {
            endedCell.label = nil
        }
    }
    
    
    
    
    
    //MARK:- BUTTONS AND LABELS
    var count = 0
    
    @IBAction func addTextButton(_ sender: UIButton) {
        if !isButtonEnabled {
            texts.append(textField.text!)
            let insertedIndex = IndexPath(item: texts.count - 1, section: 0)
            textCollectionView.insertItems(at: [insertedIndex])
        }
        textField.text = "Enter name"
        textField.alpha = 0.5
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if textField.text == "" {
            textField.text = "Enter name"
            textField.alpha = 0.5
            }
        }
    }
    
    
    @IBAction func minusButton(_ sender: Any) {
        if !texts.isEmpty{
            isButtonEnabled = !isButtonEnabled
            if let indexPath = textCollectionView?.indexPathsForVisibleItems {
                for indexPath in indexPath {
                    if let cell = textCollectionView.cellForItem(at: indexPath) as? TextCollectionViewCell {
                        cell.isEditing = isButtonEnabled
                    }
                }
            }
            
            viewDidLoad()
        }
    }
    
    @IBOutlet weak var textCollectionView: UICollectionView! {
        didSet {
            textCollectionView.dataSource = self
            textCollectionView.delegate = self
        }
    }
    
    @IBOutlet weak var minusButtonDone: UIButton!
    
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    //MARK:- POP
    
    
    @IBAction func choose(_ sender: UIButton) {
        if !texts.isEmpty {
            choosed = texts.randomElement()!
            performSegue(withIdentifier: "pop Winner", sender: self)
        }
    }
    
    var choosed = ""
    
    
    // MARK: -TEXTS
    
    var texts : [String] = []
    
    var isButtonEnabled = false
        
    var addingText = false
    
    var didDelete = 0



// MARK: - ViewDIDLoad / Gestures
    override func viewDidLoad() {
        super.viewDidLoad()
        if isButtonEnabled {
            minusButtonDone.setImage(#imageLiteral(resourceName: "Image-3"), for: .normal)
        } else {
            minusButtonDone.setImage(#imageLiteral(resourceName: "Image-1"), for: .normal)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let vc = segue.destination as? POPViewController
            vc?.finalText = self.choosed
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if texts.isEmpty {
            alert(with: "EMPTY", and: "Add something to choose")
            return false
        } else {
            return true
        }
    }
    
    private func alert(with title: String, and message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { (action) in
               alert.dismiss(animated: true, completion: nil)
           }))
           
           self.present(alert, animated: true, completion: nil)
       }

}
