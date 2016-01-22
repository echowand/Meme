//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Guanqun Mao on 1/21/16.
//  Copyright © 2016 Guanqun Mao. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2*space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController!.tabBar.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("-----------2")
        if segue.identifier == "showEditView" {
            print("do segue...2")
            dismissViewControllerAnimated(true, completion: nil)
            if let mainViewController = segue.destinationViewController as? MainViewController{
                print("main view controller...2")
                //mainViewController.meme = Meme( topText: "TOP", bottomText: "BOTTOM", image:UIImage(), memedImage: UIImage())
                mainViewController.imagePickerView = UIImageView()
                mainViewController.topText = UITextField()
                mainViewController.bottomText = UITextField()
                //let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                //applicationDelegate.meme = Meme( topText: "TOP", bottomText: "BOTTOM", image:UIImage(), memedImage: UIImage())
            }
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        //cell.memeImage.image = meme.image
        //cell.memeImage.contentMode = .ScaleAspectFit
        cell.backgroundView = UIImageView (image: meme.memedImage)
        cell.backgroundView?.contentMode = .ScaleAspectFit
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
}
