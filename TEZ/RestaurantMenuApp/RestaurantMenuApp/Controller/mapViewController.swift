//
//  mapViewController.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 2.01.2019.
//  Copyright © 2019 Bartu akman. All rights reserved.
//

import UIKit
import  MapKit
import FirebaseAuth
import  FirebaseDatabase

class mapViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var showorderbutton: UIButton!
    @IBOutlet weak var labelKm: UILabel!
    
    
   
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
     var adminLocation = CLLocationCoordinate2D()
     var showorderhasbeencalled = true
    var roundedDistance : Double = 0.0
    var timer : Timer = Timer()
    
 
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationİnitiliaze()
 
    
       
     }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
     }
    func initiliazeTimer(){
        
        
        timer =    Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer ) in
            
            DBProvider.Instance.clientRef.child("Location").observe( .value , with: { (snapshot) in
                
                if let locationreqs = snapshot.value as? NSDictionary {
                    
                    if let lat = locationreqs["lat"] as? Double {
                        
                        if let long = locationreqs["long"] as? Double {
                            

                            let userL = CLLocation(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
                              let adminL = CLLocation(latitude: lat, longitude: long)
                            
                            self.adminLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)

                            
                            let distance = adminL.distance(from: userL) / 1000
                            self.roundedDistance = round(distance*100) / 100
                            self.labelKm.text = "\(self.roundedDistance)km away"
                            
                            print(self.roundedDistance)
                            
                            print("mesafe")
                          
                            
                            
                        }
                        
                    }
                }
                
            })
            
            
        }
        
    }
    func locationİnitiliaze () {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        

    }
    
    @IBAction func showOrder(_ sender: UIButton) {
        
         let email = AuthProvider.Instance.currentUserEmail()
            
        if   showorderhasbeencalled {
            
            showorderhasbeencalled = false
            showorderbutton.setTitle("Cancel Showing", for: .normal)
            
            DBProvider.Instance.locationRef.child("MapRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe( .childAdded, with: { (snapshot) in
                
                snapshot.ref.removeValue()
                 DBProvider.Instance.locationRef.child("MapRequests").removeAllObservers()
                
            })
            initiliazeTimer()
            
            let requestCLLocation = CLLocation(latitude: self.adminLocation.latitude, longitude: self.adminLocation.longitude)
            
            CLGeocoder().reverseGeocodeLocation(requestCLLocation) { (placemarks, error) in
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placeMark = MKPlacemark(placemark: placemarks[0])
                        let mapItem = MKMapItem(placemark: placeMark)
                        mapItem.name = "Restaurant Destination "
                        let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: options)
                     }
                }
            }
            
            
            
         }
            
        else {
            
            let requestDictionary: [String:Any] = ["email": email, "lat": userLocation.latitude, "long": userLocation.longitude]
            DBProvider.Instance.locationRef.child("MapRequests").childByAutoId().setValue(requestDictionary)
            showorderhasbeencalled = true
            showorderbutton.setTitle("Show Orders", for: .normal)
            
          timer.invalidate()
 
            
        }
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension mapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate =   manager.location?.coordinate {
            
            let center =  CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
            userLocation = center
            
            let latDelta = abs(adminLocation.latitude - userLocation.latitude) * 2 + 0.005
            let lonDelta = abs(adminLocation.longitude - userLocation.longitude) * 2 + 0.005
            
            let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
            mapview.setRegion(region, animated: true)
            
          //  let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.01, 0.01))
            //mapview.setRegion(region, animated: true)
            
            mapview.removeAnnotations(mapview.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = "Your Location"
            mapview.addAnnotation(annotation)
            
            
            
            let adminAnno = MKPointAnnotation()
            adminAnno.coordinate = adminLocation
            adminAnno.title = "Restaurant Location"
            mapview.addAnnotation(adminAnno)
            
            
            
            
        }
        
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        
        manager.stopUpdatingLocation()
    }
}
