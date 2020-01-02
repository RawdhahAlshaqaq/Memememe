//
//MemeEditorViewController.swift
//  memeMe
//
//  Created by Rawdhah alshaqaq on 9/29/19.
//  Copyright © 2019 Rawdhah alshaqaq. All rights reserved.
//

import UIKit
/*
struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage : UIImage
    
}
 */

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    var meme : Meme!
    @IBOutlet weak var imagePickerViewer: UIImageView!
  
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    @IBOutlet weak var topText: UITextField!
    
    
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    

    @IBOutlet weak var UpToolBar: UIToolbar!
    
    
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black ,
        NSAttributedString.Key.foregroundColor: UIColor.white ,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.12
    ]
    
   
    func configure(_ textField: UITextField, defaultText: String) {
        
        textField.delegate = self
        textField.text = defaultText
       // textField.textAlignment = NSTextAlignment.center
        textField.defaultTextAttributes = memeTextAttributes
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configure(topText, defaultText: "TOP")
        configure(bottomText, defaultText: "BOTTOM")
        topText.textAlignment = NSTextAlignment.center
        bottomText.textAlignment = NSTextAlignment.center
        
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
       cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
       
        if(imagePickerViewer == nil){
            shareButton.isEnabled = false
        }else {
            
             shareButton.isEnabled = true
        }
        

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
          unsubscribeFromKeyboardNotifications()
    }
    
    func textFieldDidBeginEditing(_ textAppear: UITextField ){
      
        if (textAppear.text == "TOP" || textAppear.text == "BOTTOM" ){
                textAppear.text = " "
        }
   
    }
    
    func textFieldShouldReturn(_ textApear: UITextField) -> Bool{
        
        textApear.resignFirstResponder()
        return true
        
    }
    

    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
         if bottomText.isFirstResponder {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
         if bottomText.isFirstResponder {
        view.frame.origin.y = 0
        }
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerViewer.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    
    }
    
    
    func  hideUnhideTheNavAndToolBar(_ hidden: Bool){
         self.navigationController?.setNavigationBarHidden(hidden, animated: hidden)
         self.navigationController?.setToolbarHidden(hidden, animated: hidden)

         toolBar.isHidden = hidden
         UpToolBar.isHidden = hidden
        
         albumButton.accessibilityElementsHidden = hidden
         cameraButton.accessibilityElementsHidden = hidden
         shareButton.accessibilityElementsHidden = hidden
         cancelButton.accessibilityElementsHidden = hidden
    }
    
    func generateMemedImage() -> UIImage {
        
       
        hideUnhideTheNavAndToolBar(true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideUnhideTheNavAndToolBar(false)
     
      
        return memedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerViewer.image = image
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func clickTheAlbumAndCamera(_ source: UIImagePickerController.SourceType){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        //imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = source
        
    }
    
    
    @IBAction func pickImage(_ sender: Any) {
        
 
        clickTheAlbumAndCamera(.photoLibrary)
 
    }
   
   

    @IBAction func pickImageForCamera(_ sender: Any) {
    
        clickTheAlbumAndCamera(.camera)

        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func shareImage(_ sender: Any) {
   
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        controller.completionWithItemsHandler = { activity ,complete, stuff, error in if complete {
            
            self.save()
            self.dismiss(animated: true, completion: nil)
                }
            
            }
        
            self.present(controller, animated: true, completion: nil)
    
    
    }
    


  
}

