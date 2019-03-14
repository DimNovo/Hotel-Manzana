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
    private var guestFirstName: String?
    private var guestLastName: String?
    private var registrations = [Registration]()
    
    // MARK: - ... UIViewController Methods
    override func viewDidLoad()
        {
            super.viewDidLoad()
            registrations = Registration.loadData() ?? []
        }
    
    
    // MARK: - ... Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "GuestsRegistrationSegue" else
        {
            return
        }
        
        let controller = segue.destination as! UINavigationController
        let rootController = controller.viewControllers.first as! RegistrationTableViewController
        
        rootController.registration.firstName = guestFirstName!
        rootController.registration.lastName = guestLastName!
    }
    
    // MARK: - ... Unwind Segue
    @IBAction func unwind(segue: UIStoryboardSegue)
    {
        let sourse = segue.source as! RegistrationTableViewController
        let registration = sourse.registration
        
        // Edited Cell
        if let indexPath = tableView.indexPathForSelectedRow
        {
            registrations[indexPath.row] = registration
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        else
        {   // Aded Cell
            let indexPath = IndexPath(row: registrations.count, section: 0)
            registrations.append(registration)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - ... Methods
    func configure(cell: UITableViewCell, with guestRegistration: Registration)
    {
        cell.textLabel?.text = guestRegistration.firstName
        cell.detailTextLabel?.text = guestRegistration.lastName
        
    }
}

// MARK: - ... GuestsListTableViewController Extensions
extension GuestsListTableViewController
{
    // MARK: - ... UITabelViewDelegate Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guestFirstName = registrations[indexPath.row].firstName
        guestLastName = registrations[indexPath.row].lastName
        
        performSegue(withIdentifier: "GuestsRegistrationSegue", sender: self)
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
        let guest = registrations[indexPath.row]
        
        configure(cell: cell, with: guest)
        
        return cell
    }
}
