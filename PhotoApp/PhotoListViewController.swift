//
//  PhotoListViewController.swift
//  PhotoApp
//
//  Created by Felipe Gabriel on 11/01/2020.
//  Copyright © 2020 Felipe Gabriel. All rights reserved.
//

import UIKit
import PureLayout
import Alamofire

class PhotoListViewController: UIViewController {

    let tableView = UITableView.newAutoLayout()
    let label = UILabel.newAutoLayout()
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        title = "Photos"
        configureTableView()
        
        AF.request("https://jsonplaceholder.typicode.com/photos", method: .get, encoding:JSONEncoding.default).validate().responseJSON { response in
            guard let data = response.value else { return }

            if let error = response.error {
                debugPrint(error)
            } else {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    self.photos = try JSONDecoder().decode([Photo].self, from: jsonData)
                    self.tableView.reloadData()
                } catch let jsonError {
                    debugPrint("JSON Parse Error:\(jsonError)")
                }
            }
        }
    }
    
    // MARK: - TableView Setup
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(PhotoCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.autoPinEdge(toSuperviewEdge: .top)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Navigation

}

    // MARK: - Table Cell count and Photo set

extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        cell.setCellPhoto(p: photos[indexPath.row])
        return cell
    }
    
}
