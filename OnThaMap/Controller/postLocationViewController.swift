//  postLocationViewController.swift
//  OnThaMap
//  Created by Khaled Kutbi on 25/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.


import UIKit
import MapKit

class postLocationViewController: UIViewController , MKMapViewDelegate{

    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
  
    //MARK: - Properties
    var placemark = [CLPlacemark]()
    var mediaURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      configurMapUI()
      
        
    }
    
    
    //MARK:- Actions
    
    @IBAction func FinishButton(_ sender: Any) {
        
        UdacityClient.postStudentLocation(location: MKPlacemark(placemark: placemark[0]) , mediaURL: mediaURL, completion: handlePostLocationRequest(success:errror:))
    }
    
    
    
    
    //MARK: - Handlers
    func configurMapUI() {
        // Prepare map
        self.mapView.delegate = self
        mapView.centerCoordinate = placemark[0].location!.coordinate
        mapView.addAnnotation(MKPlacemark(placemark: placemark[0]))
        let region = MKCoordinateRegion(center: mapView.centerCoordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        mapView.setRegion(region, animated: true)

        
    }
  
    func handlePostLocationRequest(success: Bool,errror:Error?){
        if success {
           let tabbar = storyboard?.instantiateViewController(withIdentifier: "toTabbar") as! UITabBarController
            tabbar.modalPresentationStyle = .fullScreen
                present(tabbar, animated: true, completion: nil)
        }else{
            showALert(title: "Failad", message: "Coulde not post")
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }



}
