//
//  RoomSelectionTableViewController.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 06/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

class RoomSelectionTableViewController: UITableViewController
{
    
    // MARK: - ... Properties
    var selectedRoomType: RoomType?
    
    // MARK: - ... Methods
    func configure(cell: UITableViewCell, with roomType: RoomType)
    {
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "$\(roomType.price)"
        
        
        guard let selectedRoomType = selectedRoomType else
            
        {
            return
        }
        
        cell.accessoryType = roomType == selectedRoomType ? .checkmark : .none
    }
}

// MARK: - ... RoomSelectionTableViewController Extensions
extension RoomSelectionTableViewController
{
    
    // MARK: - ... UITabelViewDelegate Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let roomType = RoomType.all[row]
        
        selectedRoomType = roomType
        tableView.reloadData()
    }
    
    // MARK: - ... UITabelViewDataSource Protocol
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomSelectionCell")!
        
        let row = indexPath.row
        let roomType = RoomType.all[row]
        
        configure(cell: cell, with: roomType)
        return cell
    }
}
