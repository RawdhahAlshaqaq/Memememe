//
//  CollectionViewController.swift
//  memeMe
//
//  Created by Rawdhah alshaqaq on 10/11/19.
//  Copyright © 2019 Rawdhah alshaqaq. All rights reserved.
//

import Foundation
import UIKit


class CollectionViewController: UICollectionViewController {
    
   /* var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    */
   // let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let imageMeme = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row]
    
        cell.imageViwer?.image = imageMeme.memedImage
        //cell.imageViwer.image = UIImage(named: imageMeme.memedImage)
       

        return cell

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        let imageMeme = storyboard!.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        imageMeme.meme = memes[(indexPath as NSIndexPath).row]
      
        self.navigationController!.pushViewController(imageMeme, animated: true)
        
        
    }
    
    
    
    
    
    
}
