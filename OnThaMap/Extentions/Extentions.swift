
//  Extentions.swift
//  MemeMe
//
//  Created by Khaled Kutbi on 11/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
import UIKit

extension UIViewController{
    
    func showALert(title : String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}

extension UITextField{

    func setLeftImage(imageName:String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        imageView.image = UIImage(named: imageName)
        self.leftView = imageView
        self.leftViewMode = .always

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 15))
        view.addSubview(imageView)
        leftView = view
        
        view.addSubview(imageView)
    }
    
}
