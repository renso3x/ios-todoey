//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Romeo Enso on 05/01/2018.
//  Copyright © 2018 Romeo Enso. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    //MARK: - Table DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name

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
    
    //MARK: - Table Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItem" {
            let destinationVC = segue.destination as! TodoListTableVC
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
                destinationVC.navigationItem.title = categories?[indexPath.row].name
            }
           
        }
    }
    
}





