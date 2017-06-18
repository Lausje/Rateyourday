//
//  SettingsViewController.swift
//  Rate your day
//
//  Created by Laura van der Stee on 17-06-17.
//  Copyright © 2017 Laura van der Stee. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var vragengesteld = 0
    var savedvragen = 0
    var vraag : Vraag? = nil
    var vragen : [Vraag] = []
    var rowsinsection0 = 1
    @IBOutlet weak var questionlabel1: UILabel!
    
    @IBOutlet weak var vraagtext1: UITextField!
    @IBOutlet weak var save1: UIButton!
    
    @IBOutlet weak var vraagtext2: UITextField!
    @IBOutlet weak var save2: UIButton!
    
    @IBOutlet weak var vraagtext3: UITextField!
    @IBOutlet weak var save3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            vragen = try context.fetch(Vraag.fetchRequest())
            tableView.reloadData()
        } catch {}
        print ("aantal vragen in database = \(vragen.count)")
        
        if vragen.count == 1 {
            questionlabel1.text = "Je hebt \(vragen.count) vraag ingevuld"
        } else {
            questionlabel1.text = "Je hebt \(vragen.count) vragen ingevuld"
        }
        
        if vragen.count == 1 {
            vraagtext1.text = vragen[0].text
        } else if vragen.count == 2 {
            vraagtext1.text = vragen[0].text
            vraagtext2.text = vragen[1].text
        } else if vragen.count == 3 {
            vraagtext1.text = vragen[0].text
            vraagtext2.text = vragen[1].text
            vraagtext3.text = vragen[2].text
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == 0 {
            rows = rowsinsection0 + vragen.count
        } else if section == 1 {
            rows = 2
        } else if section == 2 {
            rows = 3
        }
        return rows
    }
    
    
    @IBAction func addquestion(_ sender: Any) {
        rowsinsection0 += 1
        print("gestelde vragen = \(vragengesteld)")
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if (indexPath.section) == 0 {
            return true
        } else {
            return false
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBAction func save1(_ sender: Any) {
        vraagtext1.borderStyle = .none
        vraagtext1.isEnabled = false
        save1.isHidden = true
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let vraag = Vraag(context: context)
        vraag.text = vraagtext1.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print ("vragen in database = \(vragen.count)")
        vragen.append(vraag)
        print ("opgeslagen vragen = \(savedvragen)")
    }
    

    @IBAction func save2(_ sender: Any) {
        vraagtext2.borderStyle = .none
        vraagtext2.isEnabled = false
        save2.isHidden = true
        let vraag = Vraag(context: context)
        vraag.text = vraagtext2.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print ("vragen in database = \(vragen.count)")
        vragen.append(vraag)
        print ("opgeslagen vragen = \(savedvragen)")
        if savedvragen == 1 {
            questionlabel1.text = "Je hebt \(savedvragen) vraag ingevuld"
        } else {
            questionlabel1.text = "Je hebt \(savedvragen) vragen ingevuld"
        }
    }


    @IBAction func save3(_ sender: Any) {
        vraagtext3.borderStyle = .none
        vraagtext3.isEnabled = false
        save3.isHidden = true
        let vraag = Vraag(context: context)
        vraag.text = vraagtext3.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        vragen.append(vraag)
        print ("vragen in database = \(vragen.count)")
        if savedvragen == 1 {
            questionlabel1.text = "Je hebt \(savedvragen) vraag ingevuld"
        } else {
            questionlabel1.text = "Je hebt \(savedvragen) vragen ingevuld"
        }
    }
}





