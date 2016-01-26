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
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEditView" {
            if let mainViewController = segue.destinationViewController as? MainViewController{
                mainViewController.meme = Meme( topText: "TOP", bottomText: "BOTTOM", image:UIImage(), memedImage: UIImage())
                mainViewController.imagePickerView = UIImageView()
                mainViewController.topText = UITextField()
                mainViewController.bottomText = UITextField()
                let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                applicationDelegate.meme = Meme( topText: "TOP", bottomText: "BOTTOM", image:UIImage(), memedImage: UIImage())
            }
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        cell.backgroundView = UIImageView (image: meme.memedImage)
        cell.backgroundView?.contentMode = .ScaleAspectFit
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
}
