//
//  ViewController.swift
//  AppFactoryB
//
//  Created by  on 17/01/2020.
//  Copyright © 2020 klery. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var andarButton: UIButton!
    @IBOutlet weak var correrButton: UIButton!
    @IBOutlet weak var bicicletaButton: UIButton!
    
    @IBOutlet weak var kmRecorrido: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var timer : Timer?
    
    var sec :Int = 0
    var min :Int = 0
    var hor :Int = 0
    
    var pause :Int = 0
    
    var locationManager: CLLocationManager!

    var distanceTraveled: Double = 0
    let metersToMiles: Double = 0.001
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        andarButton.isSelected = true
        
        pauseButton.isEnabled = false
        finishButton.isEnabled = false
        
        pauseButton.setImage(UIImage(systemName: "pause.circle"), for: UIControl.State.normal)

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;

        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            
               locationManager.requestAlwaysAuthorization()
               locationManager.requestWhenInUseAuthorization()
           }
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        mapView.delegate = self;
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType(rawValue: 0)!
        mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        
    }
    
    func cronometro(){
        
        timer = Timer.scheduledTimer(timeInterval: 1,
        target: self,
        selector: #selector(fireTimer),
        userInfo: nil,
        repeats: true)
        
    }

    @IBAction func start(_ sender: Any) {

        cronometro()
        
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        finishButton.isEnabled = true
        
    }
    
    @objc func fireTimer() {
        
        if (min >= 59){
            
            min = 0
            hor += 1
            
        }
        
        if (sec >= 59){
            
            sec = 0
            min += 1
        }
        else {
            
            sec += 1
        }
        
        if (sec <= 9) {
            
            timeLabel.text = "0\(hor):0\(min):0\(sec)"
            
            if (min <= 9) {
                
                timeLabel.text = "0\(hor):0\(min):0\(sec)"
            }
            else{
                
                timeLabel.text = "0\(hor):\(min):0\(sec)"
            }
        }
        else {
            
            timeLabel.text = "0\(hor):0\(min):\(sec)"
            
            if (min <= 9) {
                
                timeLabel.text = "0\(hor):0\(min):\(sec)"
            }
            else{
                
                timeLabel.text = "0\(hor):\(min):\(sec)"
            }
        }
        
    }
    
    @IBAction func pause(_ sender: Any) {
        
        if (pause == 0) {

            pauseButton.setImage(UIImage(systemName: "play.circle"), for: UIControl.State.normal)
            timer?.invalidate()
            pause = 1
        }
        else {
            
            pauseButton.setImage(UIImage(systemName: "pause.circle"), for: UIControl.State.normal)
            cronometro()
            pause = 0
        }
    }
    
    @IBAction func finish(_ sender: Any) {
        
        sec = 0
        min = 0
        hor = 0
        timeLabel.text = "00:00:00"
        timer?.invalidate()
        finishButton.isEnabled = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
    }
    
    var loc = [CLLocationCoordinate2D]()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations[0].coordinate)
        
        /*
        let region = MKCoordinateRegion(center: loca, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
         */
        
        if (startButton.isEnabled == false && pause == 0) {
            
            let loca = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            
            loc.append(loca)
            
            let polyline = MKPolyline(coordinates: loc, count: loc.count)
            
            mapView.addOverlay(polyline)
        
            if startLocation == nil {
                print("startLocation is null")
                startLocation = locations.first
            }
            else {
                let lastLocation = locations.last
                let distance = startLocation.distance(from: lastLocation!)
                startLocation = lastLocation
                distanceTraveled += distance
            }
        
            let distanceTraveledString = (String(format:"%.1f", distanceTraveled * metersToMiles)) + " Km"
            kmRecorrido.text = distanceTraveledString
            
        }
        else {
            
            loc = [CLLocationCoordinate2D]()
            
        }
        
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let pr = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        pr.strokeColor = UIColor.red
        pr.lineWidth = 5
        return pr
        
    }
    
}


