//
//  GuestsListTVC+UITVDelegate+UITVDataSource.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 16/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

// MARK: - ... GuestsListTableViewController Extensions
extension GuestsListTableViewController
{
    // MARK: - ... UITabelViewDelegate Protocol
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

