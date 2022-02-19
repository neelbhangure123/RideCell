//
//  CarAnnotation.swift
//  RideCell
//
//  Created by byteridge on 19/02/22.
//

import MapKit
class CarAnnotation :NSObject, MKAnnotation {
    @objc dynamic  var coordinate: CLLocationCoordinate2D
    var car : CarDetail
    internal init(coordinate: CLLocationCoordinate2D, car: CarDetail) {
        self.coordinate = coordinate
        self.car = car
    }
    
}
