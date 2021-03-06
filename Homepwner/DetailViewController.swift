//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Piervincenzo Parisi on 15/02/17.
//  Copyright © 2017 Piervincenzo Parisi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var removeImageButton: UIBarButtonItem!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    } ()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        let key = item.itemKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        }
        else {
            item.valueInDollars = 0
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        removeImageButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: actions
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            let overlayView = UIView(frame: imagePicker.view.frame)
            let crosshairView = UIImageView(image: UIImage(named:  "crosshair"))
            crosshairView.frame = CGRect(x: overlayView.frame.size.width / 4,
                                         y: overlayView.frame.size.height / 2 - overlayView.frame.size.width / 2,
                                         width: overlayView.frame.size.width / 2,
                                         height: overlayView.frame.size.width / 2)
            crosshairView.center = CGPoint(x: overlayView.frame.size.width / 2,
                                           y: overlayView.frame.size.height / 2);
            overlayView.addSubview(crosshairView)
//            overlayView.backgroundColor = UIColor(patternImage: UIImage(named: "crosshair")!)
            imagePicker.cameraOverlayView = overlayView
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func removeImage(_ sender: UIBarButtonItem) {
        if imageView.image != nil {
            imageStore.deleteImage(forKey: item.itemKey)
            imageView.image = nil
            removeImageButton.isEnabled = false
        }
    }
}
