//
//  ViewController.swift
//  RideCell
//
//  Created by byteridge on 18/02/22.
//

import UIKit
import MapKit
import AlamofireImage
class MapViewController: UIViewController {
    @IBOutlet  weak var carsPickerView : AKPickerView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bookCarButton: UIButton!
    @IBOutlet weak var gradientView: UIView!

    let carsCollectionViewModel = CarsCollectionViewModel()
    let gradientLayer:CAGradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        carsCollectionViewModel.getCarsList()
        setUPMap()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame.size = self.gradientView.frame.size
    }
    func setUpUI() {
        bookCarButton.layer.cornerRadius = 5
        bookCarButton.layer.masksToBounds  = true
        bookCarButton.layer.borderColor = UIColor.white.cgColor
        bookCarButton.layer.borderWidth =  1
        carsPickerView.delegate = self
        carsPickerView.dataSource = self
        setUpGradientView()
    }
    func setUpGradientView() {
      
        gradientLayer.frame.size = self.gradientView.frame.size
         gradientLayer.colors =
        [UIColor.blue.withAlphaComponent(0.5).cgColor,UIColor.green.withAlphaComponent(0.5).cgColor]
         gradientView.layer.addSublayer(gradientLayer)
    }
    fileprivate func setMapRegionFrom(location : CLLocationCoordinate2D) {
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        self.mapView.setRegion(viewRegion, animated: false)
    }
    
    func setUPMap() {
        mapView.delegate  = self
        mapView.register(CarAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: CarAnnotationView.self))
        let carAnnotationsArray = carsCollectionViewModel.carsList.compactMap({ carDetail -> CarAnnotation? in
            if let carLocation =  carDetail.carLocation {
                return CarAnnotation(coordinate: carLocation, car: carDetail)
            }
          return nil
        })
        carAnnotationsArray.forEach { carAnnotation in
            mapView.addAnnotation(carAnnotation)
        }
        if let firstLocation = carsCollectionViewModel.carsList.first?.carLocation {
        setMapRegionFrom(location : firstLocation)
        }
    }
}

extension MapViewController : AKPickerViewDataSource {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return carsCollectionViewModel.carsList.count
    }
    
    func pickerView(_ pickerView: AKPickerView, carForItem item: Int) -> CarDetail {
        return carsCollectionViewModel.carsList[item]
    }
}
extension MapViewController : AKPickerViewDelegate {
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        let car = carsCollectionViewModel.carsList[item]
        if let carLocation = car.carLocation {
            setMapRegionFrom(location: carLocation)
        }
    }
}

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Leave default annotation for user location
        if annotation is MKUserLocation {
            return nil
        }

        var annotationView: MKAnnotationView?
        if let annotation = annotation as? CarAnnotation {
            let reuseID = String(describing: CarAnnotationView.self)
            let carAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? CarAnnotationView
            if carAnnotationView == nil {
                annotationView = CarAnnotationView(annotation: annotation, reuseIdentifier: String(describing: CarAnnotationView.self))
            }else {
                annotationView =  carAnnotationView
            }
            if let markerInfoView =  UIView.viewFromNibName("MarkerInfoView") as?  MarkerInfoView {
                annotationView?.canShowCallout = true
                let car = annotation.car
                markerInfoView.nameLabel.text = car.vehicleMake
                markerInfoView.descriptionLabel.text = car.licensePlateNumber
                annotationView?.detailCalloutAccessoryView = markerInfoView
            }
            if let imageUrl = URL(string: annotation.car.vehiclePicAbsoluteURL ?? "")  {
                carAnnotationView?.imageView.af.setImage(withURL: imageUrl)
            }
            annotationView?.bounds = CGRect(x: 0, y: 0, width: 55, height: 40)
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let carAnnotation = view.annotation as? CarAnnotation {
            if let idx = carsCollectionViewModel.carsList.firstIndex(of: carAnnotation.car) {
            carsPickerView.selectItem(idx)
            }
        }
    }
}
extension MapViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
