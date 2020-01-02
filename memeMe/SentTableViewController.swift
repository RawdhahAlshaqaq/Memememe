//
//  SentTableViewController.swift
//  memeMe
//
//  Created by Rawdhah alshaqaq on 10/11/19.
//  Copyright © 2019 Rawdhah alshaqaq. All rights reserved.
//

import Foundation
import UIKit

class SentTableViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        let memes = (UIApplication.shared.delegate as! AppDelegate).memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = memes.memedImage
        cell.textLabel?.text = "\(memes.topText) ... \(memes.bottomText)"
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        let imageMeme = self.storyboard!.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
        
        imageMeme.meme = memes[(indexPath as NSIndexPath).row]
        
        self.navigationController!.pushViewController(imageMeme, animated: true)
        
    }

    
}
