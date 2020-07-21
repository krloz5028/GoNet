//
//  ViewController.swift
//  GoNet
//
//  Created by Carlos Ruiz on 20/07/20.
//  Copyright © 2020 CERR. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var segmentedControl:UISegmentedControl!
    @IBOutlet var tableViewTopConstraint:NSLayoutConstraint!
    
    //MARK: Vars & constants
    let threadInterval = 0...10000
    var items = [ItemModel]()
    var threadsValues = [String]()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue",
            let vc = segue.destination as? DetailViewController,
            let item = sender as? ItemModel{
            vc.item = item
        }
    }
    
    //MARK: Helpers
    
    func fetchData(){
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                items = (try? JSONDecoder().decode([ItemModel].self, from: data)) ?? []
                
            } catch (let error){
                print(error)
            }
        }
    }
    
    func startThreads(){
        let thread1 = BlockOperation{ [weak self] in
            guard let strongSelf = self else { return }
            for i in strongSelf.threadInterval{
                DispatchQueue.main.async {
                    strongSelf.threadsValues.append("Hilo 1 | prioridad normal | \(i)")
                }
            }
        }
        //thread1.queuePriority = .normal
        //Works better with qualityOfService instead queuePriority
        thread1.qualityOfService = .default
        
        let thread2 = BlockOperation{ [weak self] in
            guard let strongSelf = self else { return }
            for i in strongSelf.threadInterval{
                DispatchQueue.main.async {
                    strongSelf.threadsValues.append("Hilo 2 | prioridad baja | \(i)")
                }
                
            }
        }
        //thread2.queuePriority = .veryLow
        //Works better with qualityOfService instead queuePriority
        thread2.qualityOfService = .background
        
        
        let thread3 = BlockOperation{ [weak self] in
            guard let strongSelf = self else { return }
            for i in strongSelf.threadInterval{
                DispatchQueue.main.async {
                    strongSelf.threadsValues.append("Hilo 3 | prioridad alta | \(i)")
                }
            }
        }
        thread3.addDependency(thread1)
        //thread3.queuePriority = .veryHigh
        //Works better with qualityOfService instead queuePriority
        thread3.qualityOfService = .userInteractive
        
        let queue = OperationQueue()
        
        queue.addOperations([thread1, thread2, thread3], waitUntilFinished: true)
        queue.addBarrierBlock { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: Button actions
    @IBAction func startButtonTapped(_ sender:UIButton){
        startThreads()
    }
    
    @IBAction func cleanButtonTapped(_ sender:UIButton){
        threadsValues = []
        tableView.reloadData()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        tableViewTopConstraint.isActive = segmentedControl.selectedSegmentIndex == 0
        tableView.reloadData()
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? items.count : threadsValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
            
            let item = items[indexPath.row]
            
            cell.titleLabel.text = item.title
            cell.descriptionLabel.text = item.description
            
            
            if let url = item.imageURL{
                cell.itemImageView?.setImage(withUrl: url)
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreadCell", for: indexPath)
            
            let threadValue = threadsValues[indexPath.row]
            
            cell.textLabel?.text = threadValue
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if segmentedControl.selectedSegmentIndex == 0{
            let item = items[indexPath.row]
            
            self.performSegue(withIdentifier: "DetailSegue", sender: item)
        }
    }
}


//MARK: - CUSTOM CELLS

class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func prepareForReuse() {
        itemImageView.image = nil
    }
}



