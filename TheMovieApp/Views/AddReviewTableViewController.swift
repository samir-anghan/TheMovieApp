//
//  AddReviewTableViewController.swift
//  TheMovieApp
//
//  Created by Samir on 10/20/19.
//  Copyright © 2019 Samir Anghan. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class AddReviewTableViewController: UITableViewController {
    
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet var formTableView: UITableView!
    
    var viewModel: ReviewMovieViewModel?
    
    private var uploadedPhotoUrl: String?
    private var rating: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formTableView.keyboardDismissMode = .onDrag
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        ratingView.addTarget(self, action: #selector(handleRating), for: .valueChanged)
    }
    
    @IBAction func didTapUploadPhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take New Photo", style: UIAlertAction.Style.default, handler: { (_:UIAlertAction!) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            else {
                self.showAlert(title: "Sorry, Can't take picture", message: "Camera not available.")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose Existing Photo", style: UIAlertAction.Style.default, handler: { (_:UIAlertAction!) -> Void in
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc private func handleRating() {
        rating = ratingView.value
    }
    
    @objc private func saveTapped() {
        guard let vm = viewModel else { return }
        
        if canSave() {
            vm.addReview(rating: rating, title: titleTextField.text, review: reviewTextView.text, uploadedPhotoUrl: uploadedPhotoUrl, {
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            showAlert(title: "Empty fileds", message: "Requied title and review.")
        }
    }
    
    private func canSave() -> Bool {
        return titleTextField.text != "" && reviewTextView.text != ""
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            if self.titleTextField.text == "" {
                self.titleTextField.becomeFirstResponder()
            } else if self.reviewTextView.text == ""  {
                self.reviewTextView.becomeFirstResponder()
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension AddReviewTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        self.titleTextField.resignFirstResponder()
        self.titleTextField.resignFirstResponder()
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            let imgName = imgUrl.lastPathComponent
            let _localPath =  StorageManager.shared.documentsUrl?.appendingPathComponent(imgName)
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
                let data = image.pngData() as NSData? else { return }
            
            guard let localPath = _localPath else { return }
            
            data.write(toFile: localPath.absoluteString, atomically: true)
            let photoURL = URL.init(fileURLWithPath: localPath.absoluteString)
            //print(photoURL)
            previewImageView.image = image
            uploadedPhotoUrl = photoURL.absoluteString
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        self.titleTextField.resignFirstResponder()
        self.titleTextField.resignFirstResponder()
    }
}
