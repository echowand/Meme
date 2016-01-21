//
//  ViewController.swift
//  MemeMe
//
//  Created by Guanqun Mao on 10/27/15.
//  Copyright © 2015 Guanqun Mao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    var meme: Meme!
    var currText: UITextField?
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5
    ]
    
    @IBAction func showImages(sender: UIBarButtonItem) {
        let picController = UIImagePickerController()
        picController.allowsEditing = true
        picController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picController.delegate = self
        presentViewController(picController, animated: true, completion: nil)
    }
    
    @IBAction func showCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func showActivity(sender: UIBarButtonItem) {
        let image = UIImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if success == true {
                self.save()
            }
        }
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelActivity(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func showAlert(sender: UIButton) {
        let alertController = UIAlertController()
        let okAction = UIAlertAction(title: "This is Title", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("?????? \(image)")
            imagePickerView.contentMode = .ScaleAspectFit
            imagePickerView.image = image
            
            topText.defaultTextAttributes = memeTextAttributes
            topText.hidden = false
            topText.textAlignment = NSTextAlignment.Center
            
            bottomText.defaultTextAttributes = memeTextAttributes
            bottomText.hidden = false
            bottomText.textAlignment = NSTextAlignment.Center
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func save() {
        //Create the meme
        let memedImage = generateMemedImage()
        let meme = Meme( topText: topText.text!, bottomText: bottomText.text!, image:imagePickerView.image!, memedImage: memedImage)
        self.meme = meme
        // Add it to the memes array in the Application Delegate
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    // Create a UIImage that combines the Image View and the Textfields
    func generateMemedImage() -> UIImage {
        // render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return memedImage
    }
    
    //////////////// Textfield /////////////////////////
    func textFieldDidBeginEditing(textField: UITextField) {
        currText = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        currText = nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    ///////////////// Textfield End ////////////////////
    
    ///////////////// Keyboard /////////////////////////
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomText == currText {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    ///////////////// Keyboard End //////////////////////
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController!.toolbarHidden = false;
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        meme = appDelegate.meme
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        topText.delegate = self
        bottomText.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
}

