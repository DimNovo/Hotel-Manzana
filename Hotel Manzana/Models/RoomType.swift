//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by Dmitry Novosyolov on 02/03/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

struct RoomType
{
    var id: Int
    var name: String
    var shortName: String
    var price: Int
}

extension RoomType: Equatable
{
   static func == (left: RoomType, right: RoomType) -> Bool
   {
        return left.id == right.id
    }
}
