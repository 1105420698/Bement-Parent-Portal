//
//  InstagramTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/27/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import Kingfisher
import SkeletonView
import Fuzi

class FacebookTableViewController: UITableViewController {
    
    var reloaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppDelegate.facebookItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let datePub = formatter.string(from: AppDelegate.facebookItems[indexPath.row].pubDate!)
        
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! FacebookWithImageTableViewCell
        
        cellWithImage.dateOfPub.text = "Date: \(datePub)"
        
        do {
            let doc = try HTMLDocument(string: AppDelegate.facebookItems[indexPath.row].description!, encoding: String.Encoding.utf8)
            if doc.body!.children[0].stringValue == "\n      \n      \n    " {
                cellWithImage.content.text = ""
            } else {
                cellWithImage.content.text = doc.body?.children[0].children[1].stringValue
            }
        } catch let error {
            print(error)
        }
        
        if let url = AppDelegate.facebookItems[indexPath.row].enclosure?.attributes!.url {
            cellWithImage.contentImage.showAnimatedSkeleton()
            cellWithImage.contentImage.kf.setImage(
                with: URL(string: url),
                options: [
                .scaleFactor(UIScreen.main.scale)
                ]) { _ in
                cellWithImage.contentImage.hideSkeleton()
            }
        } else {
            cellWithImage.contentImage.isHidden = true
            cellWithImage.contentImage.removeConstraints(cellWithImage.contentImage.constraints)
        }
        
        if indexPath.row == 4 && !reloaded {
            tableView.reloadData()
            reloaded = true
        }
        
        return cellWithImage
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        
        if userInterfaceStyle == .dark {
        } else {
        }
    }
}
