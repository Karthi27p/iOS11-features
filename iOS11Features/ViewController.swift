//
//  ViewController.swift
//  iOS11Features
//
//  Created by Karthi on 21/10/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var markFavourite : Bool = false
    var previousIndex : IndexPath = []
    var searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.markFavourite = false
        self.navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(indexPath.row)"
        if(markFavourite == true)
        {
            cell.imageView?.image = UIImage(named: "favourite")
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailPage", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favourite", handler: {(action, view, completionHandler) in
            
            self.updateFavourite(index: indexPath)
            completionHandler(true)})
        if(indexPath != previousIndex)
        {
            self.markFavourite = false
            action.title = "Favourite"
        }
        if(markFavourite == true)
        {
            action.title = "UnFavourite"
        }
        action.backgroundColor = UIColor.orange
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "delete", handler: {(action, view, completionHandler) in
            completionHandler(true)
        })
        action.backgroundColor = UIColor.red
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    func updateFavourite(index: IndexPath)
    {
        
        self.markFavourite = !self.markFavourite
        self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.none)
        previousIndex = index
    }

}

