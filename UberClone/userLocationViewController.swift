//
//  userLocationViewController.swift
//  UberClone
//
//  Created by Eslam Moemen on 2018-07-01.
//  Copyright © 2018 Eslam Moemen. All rights reserved.


import UIKit
import MapKit
import FirebaseAuth
import FirebaseDatabase

class userLocationViewController: LoginViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var callButton: UIButton!
    
    var uberCalled = false
    
    let location = CLLocationManager()
    
    var userLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        
          let email = Auth.auth().currentUser?.email
       
        
            Database.database().reference().child("userData").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded) { (snapshot) in
                
                self.uberCalled = true
                self.callButton.setTitle("Cancel Request", for: .normal)
                Database.database().reference().child("userData").removeAllObservers()
            
        }
        
       
        }
        
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let coord = manager.location?.coordinate
        let center = CLLocationCoordinate2D(latitude: coord!.latitude, longitude: coord!.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
            userLocation = center
            map.setRegion(region, animated: true)
            map.removeAnnotations(map.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            map.addAnnotation(annotation)
        
        
    }

    @IBAction func callUber(_ sender: Any) {
      
        let email = Auth.auth().currentUser?.email
       
        if uberCalled == true {
            
            callButton.setTitle("Call Uber", for: .normal)
            uberCalled = false
            
            Database.database().reference().child("userData").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded){ (snapshot) in
                
                snapshot.ref.removeValue()
                Database.database().reference().child("userData").removeAllObservers()
            }
            
        }else{
            
            let userData : [String:Any] = ["email":email!,"latitude":userLocation.latitude, "longitude":userLocation.longitude]
            
            
            Database.database().reference().child("userData").childByAutoId().setValue(userData)
            callButton.setTitle("Cancel Request", for: .normal)
            uberCalled = true
            
        }
  
        
    }
    
  
    
    @IBAction func signOut(_ sender: Any) {
        try? Auth.auth().signOut()
        
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
  

}
