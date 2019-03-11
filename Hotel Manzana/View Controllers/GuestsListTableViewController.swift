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
    
    // MARK: - ... Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "GuestsRegistrationSegue" else
        {
            return
        }
        
        let controller = segue.destination as! UINavigationController
        let rootController = controller.viewControllers.first as! RegistrationTableViewController
        
        rootController.guestToFirstName = guestFirstName
        rootController.guestToLastName = guestLastName
    }
    
    // MARK: - ... Unwind Segue
    @IBAction func unwind(segue: UIStoryboardSegue) {}
    
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
        
        guestFirstName = Registration.allGuests[indexPath.row].firstName
        guestLastName = Registration.allGuests[indexPath.row].lastName
        
        performSegue(withIdentifier: "GuestsRegistrationSegue", sender: self)
    }
    
    // MARK: - ... UITabelViewDataSource Protocol
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Registration.allGuests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestRegistrationCell")!
        let guest = Registration.allGuests[indexPath.row]
        
        configure(cell: cell, with: guest)
        
        return cell
    }
}
