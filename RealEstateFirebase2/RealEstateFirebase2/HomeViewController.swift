//
//  HomeViewController.swift
//  RealEstateFirebase2
//
//  Created by selinay ceylan on 5.03.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countryArray = [String]()
    var emailArray = [String]()
    var priceArray = [String]()
    var imageArray = [String]()
    var housetypeArray = [String]()
    var telehoneNumberArray = [String]()
    var numberofRoomsArray = [String]()
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
        
    }
    
    func getDataFromFirebase() {
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
       
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.countryArray.removeAll(keepingCapacity: false)
                    self.priceArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.numberofRoomsArray.removeAll(keepingCapacity: false)
                    self.telehoneNumberArray.removeAll(keepingCapacity: false)
                    self.housetypeArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let email = document.get("postedBy") as? String {
                            self.emailArray.append(email)
                        }
                        if let country = document.get("country") as? String {
                            self.countryArray.append(country)
                        }
                        if let price = document.get("price") as? String {
                            self.priceArray.append(price)
                        }
                        if let image = document.get("imageUrl") as? String {
                            self.imageArray.append(image)
                        }
                        if let house = document.get("houseType") as? String {
                            self.housetypeArray.append(house)
                        }
                        if let telephone = document.get("telephoneNumber") as? String {
                            self.telehoneNumberArray.append(telephone)
                        }
                        if let room = document.get("numerofRooms") as? String {
                            self.numberofRoomsArray.append(room)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.countText.text = "Country: \(countryArray[indexPath.row])"
        cell.emailText.text = emailArray[indexPath.row]
        cell.pricText.text = "Price :\(priceArray[indexPath.row]) $"
        cell.houseTypeText.text = "House Type: \(housetypeArray[indexPath.row])"
        cell.telephoneNumberText.text = "Telephone Number: \(telehoneNumberArray[indexPath.row])"
        cell.numberofRoomsText.text = "Number of Rooms: \(numberofRoomsArray[indexPath.row])"
        cell.imageVie.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0 // İstediğiniz yüksekliği burada belirtin
    }
    
}
