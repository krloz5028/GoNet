//
//  DetailViewController.swift
//  GoNet
//
//  Created by Carlos Ruiz on 20/07/20.
//  Copyright © 2020 CERR. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var item:ItemModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item{
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            if let url = item.imageURL{
                itemImageView.setImage(withUrl: url)
            }
        }
    }
}
