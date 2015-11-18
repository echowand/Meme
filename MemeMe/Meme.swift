//
//  Meme.swift
//  MemeMe
//
//  Created by Guanqun Mao on 10/30/15.
//  Copyright © 2015 Guanqun Mao. All rights reserved.
//

import Foundation
import UIKit

class Meme{
    var text:String
    var image:UIImage
    var memedImage:UIImage
    
    init (text:String, image:UIImage, memedImage:UIImage){
        self.text = text
        self.image = image
        self.memedImage = memedImage
    }
    
}