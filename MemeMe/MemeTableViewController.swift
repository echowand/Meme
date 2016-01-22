//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Guanqun Mao on 1/21/16.
//  Copyright © 2016 Guanqun Mao. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController{
    
    let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell")!
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.image
        cell.textLabel?.text = meme.topText + meme.bottomText
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}