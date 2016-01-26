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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController!.tabBar.hidden = false
        tableView.reloadData()
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell") as! MemeTableViewCell
        let meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        cell.memeImage.image = meme.memedImage
        cell.memeImage.contentMode = .ScaleAspectFit
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
}