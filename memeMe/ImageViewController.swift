//
//  ImageViewController.swift
//  memeMe
//
//  Created by Rawdhah alshaqaq on 10/11/19.
//  Copyright © 2019 Rawdhah alshaqaq. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController: UIViewController{
    
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.imageView.image = meme.memedImage
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    
}
