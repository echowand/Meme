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

    let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.memeImage.image = meme.image
        cell.memeImage.contentMode = .ScaleAspectFit
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
}
