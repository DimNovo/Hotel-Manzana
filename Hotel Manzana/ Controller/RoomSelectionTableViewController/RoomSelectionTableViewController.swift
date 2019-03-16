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
        
        guard let selectedRoomType = selectedRoomType else { return }
        
        cell.accessoryType = roomType == selectedRoomType ? .checkmark : .none
    }
}
