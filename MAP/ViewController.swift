//
//  ViewController.swift
//  MAP
//
//  Created by Dmitry Kulakoff on 06.10.15.
//  Copyright © 2015 Dmitriy Kulakov. All rights reserved.
//

import UIKit
import Mapbox
import CoreLocation

class ViewController: UIViewController, MGLMapViewDelegate, CLLocationManagerDelegate{
    
    var isCurrentLocation = true
    var mapView: MGLMapView!
    let locationManager = CLLocationManager()
    var bubble : AnnotationView?
    var calloutView = SMCalloutView()
    let currentLocationCoordinate = CLLocationCoordinate2D(latitude: 55.755786,
        longitude: 37.617633)
    var currentCompanies = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        locationManager.delegate = self
        //        locationManager.requestAlwaysAuthorization()
        //        if CLLocationManager.locationServicesEnabled(){
        //            locationManager.startUpdatingLocation()
        //        }
        //        let tap = UITapGestureRecognizer(target: self, action: "tapped:")
        //        mapView.addGestureRecognizer(tap)
        self.currentCompanies = CoreDataCoordinator.sharedInstance.allCompanies()
        self.configurateMapView(self.currentLocationCoordinate)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurateMapView(coordinate : CLLocationCoordinate2D){
        // initialize the map view
        mapView = MGLMapView(frame: view.bounds)
        mapView.delegate = self
        //mapView = MGLMapView(frame: view.bounds, styleURL: NSURL(string: "asset://styles/light-v8.json"))//custom style
        mapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        // set the map's center coordinate
        let bounds = MGLCoordinateBounds(sw: coordinate,
            ne: coordinate)
        mapView.setVisibleCoordinateBounds(bounds, animated: true)
        //        mapView.setCenterCoordinate(coordinate,
        //            zoomLevel: 17, animated: true)//alternative
        view.addSubview(mapView)
        // Add annotation `point` to the map
        self.addMarkersFromCompanies(self.currentCompanies)
    }
    
    func addMarkersFromCompanies(companies : NSArray){
        for var i = 0; i < companies.count; i++ {
            let company = self.currentCompanies[i] as! Company
            let latitude = Double(company.latitude!)
            let longitude = Double(company.longitude!)
            print(longitude)
            let marker = MGLPointAnnotation()
            marker.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            marker.title = company.name
            marker.subtitle = company.address
            self.mapView.addAnnotation(marker)
        }
    }
    
    // MARK: - MGLMapView Delegate
    
    func mapView(mapView: MGLMapView, didSelectAnnotation annotation: MGLAnnotation) {
        
        bubble = AnnotationView(frame: CGRectMake(0, 0, 233, 110))
        self.calloutView.contentView = bubble!
        self.calloutView.contentViewInset = UIEdgeInsetsMake(0,0, -17, 0)
        bubble?.nameLabel.text = annotation.title!
        bubble?.addressLabel.text = annotation.subtitle!
        self.calloutView.calloutOffset = CGPointMake(0,-30)
        self.calloutView.hidden = false
        
        let point = mapView.convertCoordinate(annotation.coordinate, toPointToView: self.view)
        var calloutRect: CGRect = CGRectZero
        calloutRect.origin = point
        calloutRect.size = CGSizeZero
        self.calloutView.presentCalloutFromRect(calloutRect, inView: mapView, constrainedToView: mapView, animated: true)
    }
    
    func mapView(mapView: MGLMapView, didDeselectAnnotation annotation: MGLAnnotation) {
        calloutView.dismissCalloutAnimated(true)
    }
    
    
    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage? {
        var annotationImage = mapView.dequeueReusableAnnotationImageWithIdentifier("point")
        
        if annotationImage == nil {
            // Leaning Tower of Pisa by Stefan Spieler from the Noun Project
            let image = UIImage(named: "point")
            annotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: "point")
        }
        
        return annotationImage
    }
    
//    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//        return true
//    }
//    
//    func tapped(tap : UITapGestureRecognizer){
//        let point = tap.locationInView(self.mapView)
//        print(mapView.convertPoint(point, toCoordinateFromView: self.mapView))
//    }
    // MARK: - LocationManager Delegate
    
    //    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
    //        if isCurrentLocation {
    //            isCurrentLocation = false
    //            self.configurateMapView(newLocation.coordinate)
    //        }
    //    }
    //
    //    func mapViewDidFinishRenderingMap(mapView: MGLMapView, fullyRendered: Bool) {
    //        if fullyRendered{
    //            locationManager.startUpdatingLocation()
    //        }
    //    }
    
}