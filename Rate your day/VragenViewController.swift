//
//  VragenViewController.swift
//  Rate your day
//
//  Created by Laura van der Stee on 18-06-17.
//  Copyright © 2017 Laura van der Stee. All rights reserved.
//

import UIKit

class VragenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var vragen : [Vraag] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            vragen = try context.fetch(Vraag.fetchRequest())
            tableView.reloadData()
        } catch {}
        print (vragen.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vragen.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let vraag = vragen[indexPath.row]
        cell.textLabel?.text = vraag.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete")   { (_ rowAction: UITableViewRowAction, _ indexPath: IndexPath) in
            let vraag = self.vragen[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(vraag)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                self.vragen = try context.fetch(Vraag.fetchRequest())
                tableView.reloadData()
            } catch {}
        }
        return [deleteAction]
    }
}
