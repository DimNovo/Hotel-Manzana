//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 02/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import Foundation

struct Registration
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
    
    static func loadData() -> [Registration]?
    {
        return [
            Registration(firstName: "Adriana", lastName: "Lima", emailAddress: "monaco@icloud.com", checkInDate: Date(),
                         checkOutDate: Date(), numberOfAdults: Int(), numberOfChildren: Int(), wifi: Bool(),
                         roomType: RoomType(id: Int(), name: String(), shortName: String(), price: Int())),
            Registration(firstName: "Kendall", lastName: "Jenner",emailAddress: "monaco@icloud.com", checkInDate: Date(),
                         checkOutDate: Date(), numberOfAdults: Int(), numberOfChildren: Int(), wifi: Bool(),
                         roomType: RoomType(id: Int(), name: String(), shortName: String(), price: Int())),
            Registration(firstName: "Alessandra", lastName: "Ambrósio",emailAddress: "monaco@icloud.com", checkInDate: Date(),
                         checkOutDate: Date(), numberOfAdults: Int(), numberOfChildren: Int(), wifi: Bool(),
                         roomType: RoomType(id: Int(), name: String(), shortName: String(), price: Int())),
            Registration(firstName: "Bar", lastName: "Refaeli",emailAddress: "monaco@icloud.com", checkInDate: Date(),
                         checkOutDate: Date(), numberOfAdults: Int(), numberOfChildren: Int(), wifi: Bool(),
                         roomType: RoomType(id: Int(), name: String(), shortName: String(), price: Int())),
            Registration(firstName: "Lily", lastName: "Aldridge",emailAddress: "monaco@icloud.com", checkInDate: Date(),
                         checkOutDate: Date(), numberOfAdults: Int(), numberOfChildren: Int(), wifi: Bool(),
                         roomType: RoomType(id: Int(), name: String(), shortName: String(), price: Int())),
            Registration(firstName: "Cara", lastName: "Delevingne",emailAddress: "monaco@icloud.com", checkInDate: Date(),
                         checkOutDate: Date(), numberOfAdults: Int(), numberOfChildren: Int(), wifi: Bool(),
                         roomType: RoomType(id: Int(), name: String(), shortName: String(), price: Int())),
            Registration(firstName: "Barbara", lastName: "Palvin",emailAddress: "monaco@icloud.com", checkInDate: Date(),
                         checkOutDate: Date(), numberOfAdults: Int(), numberOfChildren: Int(), wifi: Bool(),
                         roomType: RoomType(id: Int(), name: String(), shortName: String(), price: Int())),
        ]
    }
}

