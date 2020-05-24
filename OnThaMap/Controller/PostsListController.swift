//  PostsTableViewController.swift
//  OnThaMap
//  Created by Khaled Kutbi on 17/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.

import UIKit

class PostsListController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
  


    //MARK:- Outlet
    @IBOutlet weak var postsTableView: UITableView!

    //MARK:- Properties
   

    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
       
        delegation()
      
    }
   
    //MARK: - Actions
       @IBAction func reloadAction(_ sender: Any) {
        UdacityClient.getStudentLocation(completion: handleStudentsLocationsResponse(data:error:))
        self.postsTableView.reloadData()
       }
       @IBAction func addNewPost(_ sender: Any) {
         let vc = storyboard!.instantiateViewController(withIdentifier: "newPost") as! NewPostViewController
                  navigationController?.pushViewController(vc, animated: true)
       }
       @IBAction func Logout(_ sender: Any) {
           UdacityClient.logoutRequest(completion: handleLogoutResponse(success:error:))
          
       }
     
       
       //MARK: - Handlers
     
       func handleLogoutResponse(success:Bool,error:Error?){
           if success{
               self.performSegue(withIdentifier: "toLogin", sender: nil)
           }else{
               print(error?.localizedDescription ?? "")
           }
           
       }
          func handleStudentsLocationsResponse(data: [StudentsInformation],error:Error?){
          if error != nil {
              showALert(title: "Message", message: error?.localizedDescription ?? "")
          }else{
             StudentLocationsData.studentLocations = data
       }
          
         }
    
    func delegation(){
        self.postsTableView.delegate = self
        self.postsTableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  StudentLocationsData.studentLocations.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! postsTablecell
        let currentName =  StudentLocationsData.studentLocations[indexPath.row]
        cell.name.text = currentName.firstName + " " + currentName.lastName
        cell.url.text =  StudentLocationsData.studentLocations[indexPath.row].mediaURL
        return cell
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currenMediaURL = StudentLocationsData.studentLocations[indexPath.row].mediaURL
        
        if let url = URL(string: currenMediaURL) {
            if  UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else{
                showALert(title: "Messgae", message: "can't open this URL.")
            }
      
        }else{
            showALert(title: "Messgae", message: "An invalid URL.")
        }
            tableView.deselectRow(at: indexPath, animated: true)
    
}
}
class postsTablecell: UITableViewCell{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.locationIcon.image = #imageLiteral(resourceName: "icon_pin")
        self.selectionStyle = .none
    }
}
