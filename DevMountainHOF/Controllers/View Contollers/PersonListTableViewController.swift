//
//  PersonListTableViewController.swift
//  DevMountainHOF
//
//  Created by Devin Singh on 1/23/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var people: [Person] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPeople()
    }
    
    // MARK: - Private Methods
    
    private func fetchPeople() {
        PersonController.getPeople { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let people):
                    self.people = people
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    private func presentAlertController() {
        let alert = UIAlertController(title: "Add yourself", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "First Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Last Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            
            // Get Textfields
            guard let firstNameTextField = alert.textFields?[0], let lastNameTextField = alert.textFields?[1],
            // Get First + Last names
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
                !firstName.isEmpty, !lastName.isEmpty else { return }
            // Send Data to personController
            PersonController.postPerson(firstName: firstName, lastName: lastName) { (result) in
                
            }
        }
        alert.addAction(saveAction)
        
        present(alert, animated: true)    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = people[indexPath.row]
        
        cell.textLabel?.text = person.firstName + " " + person.lastName
        cell.detailTextLabel?.text = String(person.personID ?? 0)
        
        return cell
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentAlertController()
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
