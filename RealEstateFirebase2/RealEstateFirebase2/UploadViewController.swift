//
//  UploadViewController.swift
//  RealEstateFirebase2
//
//  Created by selinay ceylan on 5.03.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var telephoneNumberText: UITextField!
    @IBOutlet weak var numberofRoomsText: UITextField!
    @IBOutlet weak var houseTypeText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }

    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func shareClicked(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
            let storage = Storage.storage()
            let storageReference = storage.reference()
            let mediaFolder = storageReference.child("media")
            
            if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
                let uuid = UUID().uuidString
                let imageReference = mediaFolder.child("\(uuid).jpg")
                imageReference.putData(data, metadata: nil) { (metadata,error) in
                    if error != nil {
                        self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    } else {
                        imageReference.downloadURL { (url, error) in
                            if error == nil {
                                let imageUrl = url?.absoluteString
                                let firestoreDatabase = Firestore.firestore()
                                var firestoreReference : DocumentReference? = nil
                                let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "telephoneNumber" : self.telephoneNumberText.text!, "numerofRooms" : self.numberofRoomsText.text!, "houseType" : self.houseTypeText.text!, "country" : self.countryText.text!, "price" : self.priceText.text!, "date" : FieldValue.serverTimestamp()] as [String : Any]
                                firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                    if error != nil {
                                        self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                    } else {
                                        self.imageView.image = UIImage(named: "select.jpg")
                                        self.countryText.text = ""
                                        self.houseTypeText.text = ""
                                        self.numberofRoomsText.text = ""
                                        self.priceText.text = ""
                                        self.telephoneNumberText.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                })
                            }
                        }
                    }
                }
            }
        } else {
          performSegue(withIdentifier: "toEntry2VC", sender: nil)
            
        }
    }

    func makeAlert(titleInput:String, messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
