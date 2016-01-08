//
//  ViewController.swift
//  MemeMe
//
//  Created by Guanqun Mao on 10/27/15.
//  Copyright © 2015 Guanqun Mao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    var memes: [Meme]!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5
    ]
    
    @IBAction func showImages(sender: UIBarButtonItem) {
        let picController = UIImagePickerController()
        picController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picController.delegate = self
        self.presentViewController(picController, animated: true, completion: nil)
    }
    
    @IBAction func showCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func showActivity(sender: UIBarButtonItem) {
        let image = UIImage()
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelActivity(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func showAlert(sender: UIButton) {
        let alertController = UIAlertController()
        let okAction = UIAlertAction(title: "This is Title", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .ScaleAspectFit
            imagePickerView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
            let textDelegate = TextDelegate()
            topText.delegate = textDelegate
            topText.defaultTextAttributes = memeTextAttributes
            topText.hidden = false
            topText.textAlignment = NSTextAlignment.Center
            
            bottomText.delegate = textDelegate
            bottomText.defaultTextAttributes = memeTextAttributes
            bottomText.hidden = false
            bottomText.textAlignment = NSTextAlignment.Center
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func save() {
        //Create the meme
        let memedImage = generateMemedImage()
        let meme = Meme( text: topText.text!, image:imagePickerView.image!, memedImage: memedImage)
        // Add it to the memes array in the Application Delegate
        (UIApplication.sharedApplication().delegate as!
            AppDelegate).memes.append(meme)
    }
    
    // Create a UIImage that combines the Image View and the Textfields
    func generateMemedImage() -> UIImage {
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return memedImage
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //self.unsubscribeFromKeyboardNotifications()
    }

}

