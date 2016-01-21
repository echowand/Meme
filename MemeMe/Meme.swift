//
//  Meme.swift
//  MemeMe
//
//  Created by Guanqun Mao on 10/30/15.
//  Copyright © 2015 Guanqun Mao. All rights reserved.
//

import Foundation
import UIKit

struct Meme{
    var topText:String
    var bottomText:String
    var image:UIImage
    var memedImage:UIImage
    
    init (topText:String, bottomText:String, image:UIImage, memedImage:UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.image = image  //original image
        self.memedImage = memedImage
    }
    
}