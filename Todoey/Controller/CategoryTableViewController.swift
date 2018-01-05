//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Romeo Enso on 05/01/2018.
//  Copyright © 2018 Romeo Enso. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError()}
        
        navBar.tintColor = FlatWhite()
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: FlatWhite()]
    }

    //MARK: - Table DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        guard let hexColour = UIColor(hexString: (categories?[indexPath.row].colour)!) else { fatalError()}
        
        cell.textLabel?.text = categories?[indexPath.row].name
        cell.backgroundColor = hexColour
        cell.textLabel?.textColor = ContrastColorOf(hexColour, returnFlat: true)
        
        return cell
    }
    
    //MARK: - Add Category Methods
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) {
            (alertText) in
            
            let category = Category()
            category.name = textField.text!
            category.colour = UIColor.randomFlat.hexValue()
            
            self.save(category: category)
        }
        
        alert.addTextField {
            (categoryTextField) in
            
            categoryTextField.placeholder = "Add a new category"
            textField = categoryTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print ("Error adding category, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - Update Data Model
    override func updateModel(at indexPath: IndexPath) {
        if let item = categories?[indexPath.row]  {
            do {
                try realm.write {
                   realm.delete(item)
                }
            } catch {
                print ("Error in deleting item, \(error)")
            }
        }
    }
    
    
    //MARK: - Table Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItem" {
            let destinationVC = segue.destination as! TodoListTableVC
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            }
           
        }
    }
    
}





