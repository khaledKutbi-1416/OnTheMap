//
//  Design.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 18/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import UIKit

class usacityLogo:UIImageView{
      override func awakeFromNib() {
             self.backgroundColor = .clear
            if self.tag == 0 {
            self.image = #imageLiteral(resourceName: "logo-u")
            }else{
            self.image = #imageLiteral(resourceName: "icon_world")
            }
    }
}
class labels: UILabel{
    
    override func awakeFromNib() {
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        if self.tag == 0 {
            self.numberOfLines = 1
               textColor = .black
            self.text = "Don't have an account?"
            self.textAlignment = .center
        }else if self.tag == 1{
           self.numberOfLines = 0
             textColor = .black
             self.textAlignment = .left
        }else {
            self.font = self.font.withSize(15)
            self.numberOfLines = 0
             textColor = .gray
             self.textAlignment = .left
        }
    }
}

class Button: UIButton{

    override func awakeFromNib() {
        
        if self.tag == 0{
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 6
            self.backgroundColor = #colorLiteral(red: 0.08781064302, green: 0.6412143111, blue: 0.8674636483, alpha: 1)
            self.tintColor = .white
            self.setTitle("LOG IN", for: .normal)
            
        }else if self.tag == 1{
            self.setTitle("Sign Up", for: .normal)
        }else if self.tag == 2{
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 6
            self.backgroundColor = #colorLiteral(red: 0.08781064302, green: 0.6412143111, blue: 0.8674636483, alpha: 1)
            self.tintColor = .white
            self.setTitle("FIND LOCATION", for: .normal)
        }else{
            self.layer.borderColor = UIColor.gray.cgColor
                self.layer.borderWidth = 1
                self.layer.cornerRadius = 6
                self.backgroundColor = #colorLiteral(red: 0.08781064302, green: 0.6412143111, blue: 0.8674636483, alpha: 1)
                self.tintColor = .white
                self.setTitle("FINISH", for: .normal)
            }

    }
}

class TextFields: UITextField{
    
     
         override func awakeFromNib() {
    
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 6
            self.textAlignment = .left
            if self.tag == 0{
                self.attributedPlaceholder = NSAttributedString(string:"Email", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
                setLeftImage(imageName: "Email")
                
                
            }else if self.tag == 1{
                self.isSecureTextEntry = true
                self.attributedPlaceholder = NSAttributedString(string:"Pasword", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
                setLeftImage(imageName: "lock")
            }else if self.tag == 2{
                self.attributedPlaceholder = NSAttributedString(string:"Location", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
            }else{
                   self.attributedPlaceholder = NSAttributedString(string:"Media url", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])
            }
         
            
        }
    
}

