//
//  CarsCollectionViewModel.swift
//  RideCell
//
//  Created by byteridge on 19/02/22.
//

import Foundation
class CarsCollectionViewModel {
   private lazy var carsJsonString = """
[{
    "id" : 84,
    "is_active" : true,
    "is_available" : true,
    "lat" : 37.779816,
    "license_plate_number" : "7LVF807",
    "lng" : -122.395447,
    "pool" : "active",
    "remaining_mileage" : 91,
    "remaining_range_in_meters" : 146000,
    "transmission_mode" : "park",
    "vehicle_make" : "BMW i3 Van",
    "vehicle_pic" : "/media/uploads/vehicles/display_pics/739c2443-5c6b-405a-9eb1-b70f30debe34.png",
    "vehicle_pic_absolute_url" : "https://d16vxu8318b851.cloudfront.net/uploads/vehicles/display_pics/739c2443-5c6b-405a-9eb1-b70f30debe34.png",
    "vehicle_type" : "BMW i3 Van",
    "vehicle_type_id" : 11

    },
    {
    "id" : 1102,
    "is_active" : true,
    "is_available" : true,
    "lat" : 47.61328,
    "license_plate_number" : "7LKJ997",
    "lng" : -122.342385,
    "pool" : "active",
    "remaining_mileage" : 37,
    "remaining_range_in_meters" : 59000,
    "transmission_mode" : "park",
    "vehicle_make" : "BMW i3 Van",
    "vehicle_pic" : "/media/uploads/vehicles/display_pics/5b96f5f8-2342-4448-8bfc-745275389988.png",
    "vehicle_pic_absolute_url" : "https://d16vxu8318b851.cloudfront.net/uploads/vehicles/display_pics/5b96f5f8-2342-4448-8bfc-745275389988.png",
    "vehicle_type" : "BMW i3 Van",
    "vehicle_type_id" : 11

    },
    {
    "id" : 4770,
    "is_active" : true,
    "is_available" : true,
    "license_plate_number" : "plate627",
    "pool" : "active",
    "remaining_mileage" : 0,
    "vehicle_make" : "BMW i3 Van",
    "vehicle_pic" : "/media/uploads/vehicles/display_pics/739c2443-5c6b-405a-9eb1-b70f30debe34.png",
    "vehicle_pic_absolute_url" : "https://d16vxu8318b851.cloudfront.net/uploads/vehicles/display_pics/739c2443-5c6b-405a-9eb1-b70f30debe34.png",
    "vehicle_type" : "BMW i3 Van",
    "vehicle_type_id" : 11
    }
    ]
"""
    var carsList : [CarDetail] = []
    func getCarsList() {
        carsList = parseJsonString(text: self.carsJsonString, type: [CarDetail].self) ?? []
    }
    func parseJsonString<T : Decodable>(text : String , type : T.Type) -> T? {
        if let data = text.data(using: .utf8) {
            if let obj = try? JSONDecoder().decode(type.self, from: data) {
                return obj
            }
        }
        return nil
    }
}
