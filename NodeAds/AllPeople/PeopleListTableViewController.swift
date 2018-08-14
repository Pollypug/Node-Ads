//
//  PeopleListTableViewController.swift
//  NodeAds
//
//  Created by Polina on 8/11/18.
//  Copyright © 2018 Polina. All rights reserved.
//

import UIKit

class PeopleListTableViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var personInfo: PersonInfo?
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "personInfoCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func search(_ sender: Any) {
        
        if searchTextField.text == nil || searchTextField.text == "" {
            isSearching = false
            view.endEditing(true)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        } else {
            isSearching = true
            
            let manager = APIClient()
            manager.search(by: searchTextField.text!) { (message, info) in
                
                guard let info = info else {
                    print(message)
                    return
                }
                
                self.personInfo = info
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPDF" {
            let destinationVC = segue.destination as! PDFReviewViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
            if let item = self.personInfo {
                let link = item.items[indexPath.row]
                destinationVC.link = link.linkPDF
            }
        }
        }
    }
    
}

extension PeopleListTableViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let info = personInfo else {
            return 0
        }
        return info.items.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personInfoCell", for: indexPath) as! TableViewCell
        
        cell.configure(with: personInfo?.items[indexPath.row])
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }}

extension PeopleListTableViewController: TableViewCellDelegate {
    
    func openPDF(at index: IndexPath) {
        performSegue(withIdentifier: "openPDF", sender: nil)
    }
 
}
