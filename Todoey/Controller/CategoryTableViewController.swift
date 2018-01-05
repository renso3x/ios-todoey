//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Romeo Enso on 05/01/2018.
//  Copyright © 2018 Romeo Enso. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    //MARK: - Table DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name

        return cell
    }
    
    //MARK: - Add Category Methods
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) {
            (alertText) in
            
            let category = Category(context: self.context)
            category.name = textField.text
            
            self.categoryArray.append(category)
            
            self.save()
        }
        
        alert.addTextField {
            (categoryTextField) in
            
            categoryTextField.placeholder = "Add a new category"
            textField = categoryTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print ("Error adding category, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print ("Error fetching category, \(error)")
        }
        
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
                destinationVC.selectedCategory = categoryArray[indexPath.row]
                destinationVC.navigationItem.title = categoryArray[indexPath.row].name
            }
           
        }
    }
    
}




