//
//  CarDetail.swift
//  RideCell
//
//  Created by byteridge on 19/02/22.
//

import Foundation
import CoreLocation
public class CarDetail : NSObject,Codable {
    static func ==(lhs: CarDetail, rhs: CarDetail) -> Bool {
       return lhs.id == rhs.id
    }
    var id: Int?
    var isActive: Bool?
    var isAvailable: Bool?
    var lat: Double?
    var licensePlateNumber: String?
    var lng: Double?
    var pool: String?
    var remainingMileage: Int?
    var remainingRangeInMeters: Int?
    var transmissionMode: String?
    var vehicleMake: String?
    var vehiclePic: String?
    var vehiclePicAbsoluteURL: String?
    var vehicleType: String?
    var vehicleTypeID: Int?
    
    var remainingMileageDescription: String {
        var remainingMilageInKm = 0
        if let remainingMileage = remainingMileage {
            remainingMilageInKm =  remainingMileage
        }else  if let remainingRangeInMeters = remainingRangeInMeters {
            remainingMilageInKm =  (remainingRangeInMeters/1000)
        }
        return "\(remainingMilageInKm) km"
    }
    
    var carLocation: CLLocationCoordinate2D? {
        if let lat = lat ,let lng = lng {
            return CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case  id , isActive = "is_active"  , isAvailable = "is_available" , lat , lng , pool , remainingMileage  =  "remaining_mileage",licensePlateNumber = "license_plate_number", remainingRangeInMeters = "remaining_range_in_meters", transmissionMode = "transmission_mode" ,vehiclePic,vehiclePicAbsoluteURL = "vehicle_pic_absolute_url",vehicleType = "vehicle_type",vehicleTypeID,vehicleMake = "vehicle_make"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decodeIfPresent(Int.self, forKey: .id)
        isActive = try? values.decodeIfPresent(Bool.self, forKey: .isActive)
        isAvailable = try? values.decodeIfPresent(Bool.self, forKey: .isAvailable)
        lat = try? values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try? values.decodeIfPresent(Double.self, forKey: .lng)
        pool = try? values.decodeIfPresent(String.self, forKey: .pool)
        remainingRangeInMeters = try? values.decodeIfPresent(Int.self, forKey: .remainingRangeInMeters)
        remainingMileage = try? values.decodeIfPresent(Int.self, forKey: .remainingMileage)
        licensePlateNumber = try? values.decodeIfPresent(String.self, forKey: .licensePlateNumber)

        transmissionMode = try? values.decodeIfPresent(String.self, forKey: .transmissionMode)
        vehiclePicAbsoluteURL = try? values.decodeIfPresent(String.self, forKey: .vehiclePicAbsoluteURL)
        vehicleType = try? values.decodeIfPresent(String.self, forKey: .vehicleType)
        vehicleMake = try? values.decodeIfPresent(String.self, forKey: .vehicleMake)

    }
}
