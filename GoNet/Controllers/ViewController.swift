//
//  ViewController.swift
//  GoNet
//
//  Created by Carlos Ruiz on 20/07/20.
//  Copyright © 2020 CERR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var items = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...10{
            items.append(ItemModel(title: "Title", description: "asdfadf asdgf kashjdgf jkhasg dfhjagsdjhkfga skjdfhgas kjdfhgask djfhgask djfagsdkjfhga skdjfhgas kdjhfga skdjfhgask djfhgas kdjfhga skdjfhgas kjdfhgask djfhgasdkfjags dfkjhagsd fkjahsgdf kajshgdf akjshdgf akjshdfga ksjdhfga ksjdhfgaskjfhg asjkhdfg akjshdfga kjfhgasd", imageURL: URL(string: "http://")!))
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = items[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        
        return cell
    }
}



class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
}
