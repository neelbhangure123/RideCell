//
//  CellIdentifiable.swift
//  boAt Wearables
//
//  Created by neelkant on 31/10/20.
//  Copyright © 2020 ByteRidge. All rights reserved.
//

import UIKit

protocol CellIdentifiable {
    
    static var nib: UINib { get }
    
    static var identifier: String { get }
    
}

extension CellIdentifiable {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
