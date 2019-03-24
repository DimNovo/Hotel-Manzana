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
        guard segue.identifier == "EditRegistrationSegue" else { return }
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        
        let controller = segue.destination as! UINavigationController
        let destination = controller.viewControllers.first as! RegistrationTableViewController
        
        destination.navigationItem.title = "Edit Registration"
        destination.registration = registrations[index]
    }
    
    // MARK: - ... Unwind Segue
    @IBAction func unwind(segue: UIStoryboardSegue)
    {
        guard segue.identifier == "SaveSegue" else { return }
        let source = segue.source as! RegistrationTableViewController
        let registration = source.registration
        
        // Edited Cell
        if  source.navigationItem.title == "Edit Registration",
            let indexPath = tableView.indexPathForSelectedRow
        {
            registrations[indexPath.row] = registration
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else
            
            // Added Cell
            if source.navigationItem.title == "New Registration",
                !source.registration.firstName.isEmpty &&
                    !source.registration.lastName.isEmpty &&
                    !source.registration.emailAddress.isEmpty
            {
                let indexPath = IndexPath(row: registrations.count, section: 0)
                registrations.append(registration)
                tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - ... Methods
    func configure(cell: UITableViewCell, with registration: Registration)
    {
        cell.textLabel?.text = (registration.firstName + " " + registration.lastName)
        cell.detailTextLabel?.text = registration.emailAddress
    }
}
