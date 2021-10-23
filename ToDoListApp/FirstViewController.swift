//
//  FirstViewController.swift
//  ToDoListApp
//  This Project enables user to maintain a list of tasks to be done.(Table View, Database(User Defaults))
//  Created by Mac on 23/10/21.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var status: UILabel!
    
    var toDoArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.toDoArray = UserDefaults.standard.stringArray(forKey: "items") ?? []
       tableview.dataSource = self
       title = "To Do List"
       statusDisplay()
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapToAdd))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
       
    }
    
    func statusDisplay(){
        if let data = UserDefaults.standard.object(forKey: "items") as? [String] {
            toDoArray = data
            status.text = "You have \(toDoArray.count) pending Tasks."
        }
        else {
            status.text = "No pending Tasks."
        }
    }
    
    @objc func tapToAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter Task", preferredStyle: .alert)
        
        present(alert, animated: true)
        
        alert.addTextField(configurationHandler: {field in
            field.placeholder = "Enter Task"
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {[weak self](_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                DispatchQueue.main.async {
                var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                currentItems.append(text)
                UserDefaults.standard.setValue(currentItems, forKey: "items")
                self?.toDoArray.append(text)
                self?.tableview.reloadData()
          }
      }
   }
}))
}
}

//MARK: Tableview Data Source Method

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        return cell
    }
    
    
}
