//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 02/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import Foundation

struct Registration: Codable
{
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var wifi: Bool
    
    var roomType: RoomType
    
    init(
        firstName: String = String(),
        lastName: String = String(),
        emailAddress: String = String(),
        checkInDate: Date = Date(),
        checkOutDate: Date = Date(),
        numberOfAdults: Int = Int(),
        numberOfChildren: Int = Int(),
        wifi: Bool = Bool(),
        roomType: RoomType = RoomType(
        id: Int(),
        name: String(),
        shortName: String(),
        price: Int()
        )
        )
    {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.numberOfAdults = numberOfAdults
        self.numberOfChildren = numberOfChildren
        self.wifi = wifi
        self.roomType = roomType
    }
    
    var encoded: Data?
    {
        let encoder = PropertyListEncoder()
        let data = try? encoder.encode(self)
        
        return data
    }
    
    init?(data: Data?)
    {
        guard let data = data else { return nil }
        let decoder = PropertyListDecoder()
        guard let registration = try? decoder.decode(Registration.self, from: data) else { return nil }
        
        self.init(firstName: registration.firstName, lastName: registration.lastName,
                  emailAddress: registration.emailAddress, checkInDate: registration.checkInDate,
                  checkOutDate: registration.checkOutDate, numberOfAdults: registration.numberOfAdults, numberOfChildren: registration.numberOfChildren, wifi: registration.wifi, roomType: registration.roomType)
    }
    
    static func loadDefaults() -> [Registration]?
    {
        return [Registration]()
    }
}
