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
    
    @IBOutlet weak var mapView: MKMapView!
    
    var timer : Timer?
    
    var sec :Int = 0
    var min :Int = 0
    var hor :Int = 0
    
    var pause :Int = 0
    
    var locationManager: CLLocationManager!
    var previousLocation : CLLocation!
    
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
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    //https://medium.com/@gayatri.hedau/mkmapview-with-mkpolyline-in-swift-8b2779d29225
    
    func locationManager(_: CLLocationManager, didUpdateTo: CLLocation, from: CLLocation){}
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        
        print((newLocation.coordinate.latitude), (newLocation.coordinate.longitude))
        
        if let oldLocationNew = oldLocation as CLLocation?{
             let oldCoordinates = oldLocationNew.coordinate
             let newCoordinates = newLocation.coordinate
             var area = [oldCoordinates, newCoordinates]
                let polyline = MKPolyline(coordinates: &area, count: area.count)
             mapView.addOverlay(polyline)
         }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        
       
            let pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor.red
            pr.lineWidth = 5
            return pr
   
        
    }
    
}


