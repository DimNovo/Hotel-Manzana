//
//  RegistrationTVC+UITVDataSource+UITVDelegate.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 16/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import UIKit

// MARK: - ... RegistrationTableViewController Extensions
extension RegistrationTableViewController
{
    // MARK: - ... UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath
        {
        case checkInLabelIndexPath:
            
            if !isCheckInPickerShow
            {
                isCheckInPickerShow.toggle()
            }
            else
            {
                isCheckOutPickerShow.toggle()
            }
            
        case checkOutLabelIndexPath:          // муть мутная...
            
            if  isCheckOutPickerShow
            {
                isCheckOutPickerShow.toggle()
            }
            else
            {
                isCheckInPickerShow.toggle()
            }
            
        default:
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath
        {
        case checkInPickerIndexPath:
            return isCheckInPickerShow ? 216 : 0
        case checkOutPickerIndexPath:
            return isCheckOutPickerShow ? 216 : 0
        default:
            return 44
        }
    }
}
