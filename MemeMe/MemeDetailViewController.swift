//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Guanqun Mao on 1/21/16.
//  Copyright © 2016 Guanqun Mao. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    var meme:Meme!
    
    @IBOutlet weak var imageView:UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme.image
        imageView.contentMode = .ScaleAspectFit
    }
}
