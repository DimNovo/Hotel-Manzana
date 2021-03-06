//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 02/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

struct RoomType: Codable
{
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    //    private init(id: Int, name: String, shortName: String, price: Int) {
    //        self.id = id
    //        self.name = name
    //        self.shortName = shortName
    //        self.price = price
    //    }
    
    static var all: [RoomType]
    {
        return
            [
                RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309),
        ]
    }
}

extension RoomType: Equatable
{
    static func == (left: RoomType, right: RoomType) -> Bool
    {
        return left.id == right.id
    }
}
