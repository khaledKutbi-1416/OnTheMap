//  NewPostViewController.swift
//  OnThaMap
//  Created by Khaled Kutbi on 17/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.


import UIKit
import CoreLocation

class NewPostViewController: UIViewController {

    
    //MARK:- Outlet
    @IBOutlet weak var locationTextField: TextFields!
    @IBOutlet weak var urlTextField: TextFields!
    @IBOutlet weak var findButton: Button!
    //MARK: - Properties
    let activityView = UIActivityIndicatorView(style: .medium)

  
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHideKeyboardOnTap()
        setupActivityIndicatory()
        
    }

    //MARK: - Actions
    @IBAction func findLocation(_ sender: Any) {
        setGeocoding(true)
        if urlTextField.text != "" {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(locationTextField.text ?? "", completionHandler: handleGeocodeLocationString(placemark:error:))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
                self.setGeocoding(false)
            }
        } else {
            setGeocoding(false)
            showALert(title: "Failed", message: "Can not find location")
            
        }
    }
    //MARK: - Hanlers
     func setupActivityIndicatory() {
            activityView.center = self.view.center
            self.view.addSubview(activityView)
    }
   
    func handleGeocodeLocationString (placemark: [CLPlacemark]?, error: Error?) -> Void {
         guard let error = error else {
             if let placemark = placemark {
                 let postLocationViewController = storyboard?.instantiateViewController(withIdentifier: "toPostLocation") as! postLocationViewController
                 postLocationViewController.placemark = placemark
                 postLocationViewController.mediaURL = urlTextField.text ?? ""
                self.navigationController!.pushViewController(postLocationViewController, animated: true)
             }
             return
         }
        showALert(title: "Message", message: error.localizedDescription)
         setGeocoding(false)
     }
    func setGeocoding(_ geocoding: Bool) {
           if geocoding {
               activityView.startAnimating()
                
           } else {
               activityView.stopAnimating()
            resetTextField(urlTextField)
            resetTextField(locationTextField)
            
           }
        self.locationTextField.isEnabled = !geocoding
           urlTextField.isEnabled = !geocoding
           findButton.isEnabled = !geocoding
       }
    
       func resetTextField(_ textField: UITextField) {
        textField.text = ""
       }
}
