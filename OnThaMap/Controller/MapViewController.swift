//  MapViewController.swift
//  OnThaMap
//  Created by Khaled Kutbi on 17/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.


import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController ,MKMapViewDelegate {
   
     //MARK: - Outlet
    @IBOutlet weak var mapView: MKMapView!
    
     //MARK: - Properties
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        UdacityClient.getStudentLocation(completion: handleStudentsLocationsResponse(data:error:))
        self.mapView.delegate = self
    }
    
    
    //MARK: - Actions
      @IBAction func reloadAction(_ sender: Any) {
        UdacityClient.getStudentLocation(completion: handleStudentsLocationsResponse(data:error:))
        mapView.reloadInputViews()
      }
      @IBAction func addNewPost(_ sender: Any) {
           let vc = storyboard!.instantiateViewController(withIdentifier: "newPost") as! NewPostViewController
        navigationController?.pushViewController(vc, animated: true)
      }
      @IBAction func Logout(_ sender: Any) {
          UdacityClient.logoutRequest(completion: handleLogoutResponse(success:error:))
         
      }
    
      
      //MARK: - Handlers
    func handleStudentsLocationsResponse(data: [StudentsInformation],error:Error?){
     if error != nil {
         showALert(title: "Message", message: error?.localizedDescription ?? "")
     }else{
        StudentLocationsData.studentLocations = data
        
        //array of location posts as Annotation of map kit
        var annotations = [MKPointAnnotation]()
        //access every location in database and take first last name, media url, cordinate long lat
        for studentLocations in StudentLocationsData.studentLocations{
            let latitude = CLLocationDegrees(studentLocations.latitude)
            let longitude = CLLocationDegrees(studentLocations.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let firstName = studentLocations.firstName
            let lastName = studentLocations.lastName
            let mediaURL = studentLocations.mediaURL
            
            //store value as annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(firstName) \(lastName)"
            annotation.subtitle = mediaURL
            
            //append it into arry of the same type
            annotations.append(annotation)
        
        }
        self.mapView.addAnnotations(annotations)
        }
    }
      func handleLogoutResponse(success:Bool,error:Error?){
          if success{
              self.performSegue(withIdentifier: "toLogin", sender: nil)
          }else{
              print(error?.localizedDescription ?? "")
          }
          
      }
    //MARK: - mapView setting up 
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
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let annotation = view.annotation, let urlString = annotation.subtitle{
                let first8 = urlString!.prefix(8)
                var checkedUrlString = ""
                if first8 == "https://"{
                    checkedUrlString = urlString!
                }else{
                    checkedUrlString = "https://" + urlString!
                }
                if let url = URL(string: checkedUrlString) {
                    if app.canOpenURL(url) {
                               app.open(url, options: ([:]), completionHandler: nil)
                        }else{
                            showALert(title: "Messgae", message: "can't open this URL.")
                        }
                  
                    }else{
                        showALert(title: "Messgae", message: "An invalid URL.")
                    }
                       
            }
        }
    }
    
}
