//
//  PhotoViewController.swift
//  EasyChooser1
//
//  Created by Kamil Gucik on 09/04/2020.
//  Copyright © 2020 Kamil Gucik. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate , PhotoCollectionViewCellDelegate,
UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - COLLECTION VIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               photos.count
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           var cell = UICollectionViewCell()
           if let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo cell", for: indexPath) as? PhotoCollectionViewCell {
               photoCell.configure(with: photos[indexPath.row])
               photoCell.delegate = self
               cell = photoCell
           }
           return cell
       }
       
       
       func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           if let endedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo cell", for: indexPath) as? PhotoCollectionViewCell {
               endedCell.photoImage = nil
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.safeAreaLayoutGuide.layoutFrame.width), height: 80);
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        photoCollectionView?.collectionViewLayout.invalidateLayout();
    }
    
    //MARK:- PHOTO
    
    
    @IBAction func takePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        photos.append(pickedImage)
            let insertedIndex = IndexPath(item: photos.count - 1, section: 0)
            photoCollectionView.insertItems(at: [insertedIndex])
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    //MARK:-
    
    

    
    @IBOutlet weak var photoCollectionView: UICollectionView!{
        didSet {
            photoCollectionView.dataSource = self
            photoCollectionView.delegate = self
        }
    }
    
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBAction func minus(_ sender: Any) {
        if !photos.isEmpty{
            isButtonEnabled = !isButtonEnabled
            if let indexPath = photoCollectionView?.indexPathsForVisibleItems {
                for index in indexPath {
                    if let cell = photoCollectionView.cellForItem(at: index) as? PhotoCollectionViewCell {
                        cell.isEditing = isButtonEnabled
                    }
                }
            }
            viewDidLoad()
        }
    }
    
    
    
    
    //MARK:- POP
    
    @IBAction func choosed(_ sender: Any) {
        if !photos.isEmpty{
        choose = photos.randomElement()
        performSegue(withIdentifier: "pop photo", sender: self)
        }
    }
    
    
    var photos : [UIImage] = []
    
    var choose: UIImage?
    
    var isButtonEnabled = false
    
    //MARK: - DELETE
    
    func delete(cell: PhotoCollectionViewCell) {
        if let pathIndex = photoCollectionView.indexPath(for: cell) {
            photos.remove(at: pathIndex.row)
            photoCollectionView.deleteItems(at: [pathIndex])
            cell.minusButtonCol.isHidden = true
            if photos.isEmpty {
                isButtonEnabled = false
                viewDidLoad()
            }
        }
    }
    
    
    // MARK: - ViewDIDLoad / Gestures
    override func viewDidLoad() {
        super.viewDidLoad()
        if isButtonEnabled {
            minusButton.setImage(#imageLiteral(resourceName: "Image-3"), for: .normal)
        } else {
            minusButton.setImage(#imageLiteral(resourceName: "Image-1"), for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? popPhotoViewController
        vc?.image = self.choose
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if photos.isEmpty {
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
