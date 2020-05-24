//
//  DogViewController.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 21/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import UIKit

class DogViewController: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var PickerView: UIPickerView!
    
    var breeds: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.PickerView.delegate = self
        self.PickerView.dataSource = self
          
        DogApi.requestListBreeds(completionHandler: handleBreedsListResponse(breeds:error:))
       
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
       }
       
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogApi.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
        
    }
    func handleBreedsListResponse(breeds:[String],error: Error?){
        self.breeds = breeds
        DispatchQueue.main.async {
            self.PickerView.reloadAllComponents()
        }
    }
   
    func handleRandomImageResponse(imageData:DogImage?,error:Error?){
        
        guard let imageURL = URL(string: imageData?.message ?? "") else{return}
        
                  DogApi.requestImageFile(url: imageURL) { (image, error) in
                     DispatchQueue.main.async {
                                       self.imageView.image = image
                                   }
                  }
    }
    func handlerImageFileResponse(image:UIImage?,error:Error?){
        DispatchQueue.main.async {
             DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
         
    }

}
