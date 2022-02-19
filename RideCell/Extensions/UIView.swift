//
//  UIView.swift
//  RideCell
//
//  Created by byteridge on 19/02/22.
//

import UIKit

extension UIView {
    class func viewFromNibName(_ name: String) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return views?.first as? UIView
    }
}
