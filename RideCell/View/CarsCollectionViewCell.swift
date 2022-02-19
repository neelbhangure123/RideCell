//
//  CarsCollectionViewCell.swift
//  RideCell
//
//  Created by byteridge on 19/02/22.
//

import UIKit

class CarsCollectionViewCell: UICollectionViewCell ,CellIdentifiable{
    @IBOutlet  weak var carTopDetailLabel : UILabel!
    @IBOutlet  weak var carNameLabel : UILabel!
    @IBOutlet  weak var carBottomDetailLabel : UILabel!
    @IBOutlet  weak var carImageView : UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(car : CarDetail) {
        carImageView.image = nil
        if let imageUrl = URL(string: car.vehiclePicAbsoluteURL ?? ""){
            carImageView.af.setImage(withURL: imageUrl)
        }
        carNameLabel.text = car.vehicleMake
        carTopDetailLabel.text = car.pool
        let remainingMilegeText  = car.remainingMileageDescription
       
        let numberPlateText  = car.licensePlateNumber

        carBottomDetailLabel.text = "\(numberPlateText ?? "")  \(remainingMilegeText)"
    }
}
