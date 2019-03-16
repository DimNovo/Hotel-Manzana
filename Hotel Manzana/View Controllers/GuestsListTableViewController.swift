//
//  GuestListTableViewController.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 08/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

class GuestsListTableViewController: UITableViewController
{
    // MARK: - ... Properties
    var registrations = [Registration]()
    
    // MARK: - ... UIViewController Methods
    override func viewDidLoad()
        {
            super.viewDidLoad()
            registrations = Registration.loadData() ?? []
        }
    
    
    // MARK: - ... Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "EditSegue" else { return }
        
        let controller = segue.destination as! UINavigationController
        let destination = controller.viewControllers.first as! RegistrationTableViewController
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        
        destination.registration = registrations[index]
        destination.navigationItem.title = "Edit"
        
        print(#function, destination.registration)
    }
    
    // MARK: - ... Unwind Segue
    @IBAction func unwind(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "SaveSegue" else { return }
        let sourse = segue.source as! RegistrationTableViewController
        let registration = sourse.registration
        
        if sourse.navigationItem.title == "Edit",
            let indexPath = tableView.indexPathForSelectedRow
        {
            registrations[indexPath.row] = registration
            
            print(#function, registration)
        }
            
        else if sourse.navigationItem.title == "New Registration",
            !sourse.registration.firstName.isEmpty &&
                !sourse.registration.lastName.isEmpty &&
                !sourse.registration.emailAddress.isEmpty
        {
            let indexPath = IndexPath(row: registrations.count, section: 0)
            registrations.append(registration)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            print(#function, registration)
        }
        tableView.reloadData()
    }
    
    // MARK: - ... Methods
    func configure(cell: UITableViewCell, with registration: Registration)
    {
        cell.textLabel?.text = (registration.firstName + " " + registration.lastName)
        cell.detailTextLabel?.text = registration.emailAddress
        
    }
}

// MARK: - ... GuestsListTableViewController Extensions
extension GuestsListTableViewController
{
    // MARK: - ... UITabelViewDelegate Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // Delete Cell
        let delete = UITableViewRowAction(style: .destructive, title: "DELETE")
        {
            (action, indexPath) in
            self.registrations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        // Copy Cell
        let insert = UITableViewRowAction(style: .normal, title: "COPY")
        {
            (action, indexPath) in
            let registrationToCopy = self.registrations[indexPath.row]
            self.registrations.insert(registrationToCopy, at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .bottom)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        insert.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        return [delete, insert]
    }
    
    // MARK: - ... UITabelViewDataSource Protocol
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return registrations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestRegistrationCell")!
        let registration = registrations[indexPath.row]
        
        configure(cell: cell, with: registration)
        
        return cell
    }
}
