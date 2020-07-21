//
//  DetailViewController.swift
//  GoNet
//
//  Created by Carlos Ruiz on 20/07/20.
//  Copyright © 2020 CERR. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    //MARK: - Vars
    var item:ItemModel?

    //MARK: - Life cycle
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
