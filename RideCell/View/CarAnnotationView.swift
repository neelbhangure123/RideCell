//
//  CarAnnotationView.swift
//  RideCell
//
//  Created by byteridge on 19/02/22.
//

import MapKit

class CarAnnotationView : MKAnnotationView {
    let imageView : UIImageView = {
       let imageView  = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(car : CarDetail,annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        if let imageUrl = URL(string: car.vehiclePicAbsoluteURL ?? "") {
            self.imageView.af.setImage(withURL: imageUrl)
        }
    }
    override func prepareForReuse() {
        imageView.image = nil
    }
}
