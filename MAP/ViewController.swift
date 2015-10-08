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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configurateMapView(coordinate : CLLocationCoordinate2D){
        // initialize the map view
        mapView = MGLMapView(frame: view.bounds)
        
        // set the map's center coordinate
        mapView.setCenterCoordinate(coordinate,
            zoomLevel: 18, animated: true)
        view.addSubview(mapView)
        mapView.delegate = self
        
//        let camera = MGLMapCamera(lookingAtCenterCoordinate: coordinate, fromDistance: 500, pitch: 45, heading: 0)
//        mapView.setCamera(camera, withDuration: 5, animationTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        
        let marker = MGLPointAnnotation()
        marker.coordinate = coordinate
//        marker.title = "title"
//        marker.subtitle = "subtitle"
    // Add annotation `point` to the map
        mapView.addAnnotation(marker)
        
        
    }
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if isCurrentLocation {
            isCurrentLocation = false
            self.configurateMapView(newLocation.coordinate)
        }
    }
    
    
    func mapView(mapView: MGLMapView, didSelectAnnotation annotation: MGLAnnotation) {
        
        bubble = AnnotationView(frame: CGRectMake(0, 0, 233, 110))
        //self.calloutView.title = annotation.title
        //self.calloutView.subtitle = annotation.subtitle
        self.calloutView.contentView = bubble!
        self.calloutView.contentViewInset = UIEdgeInsetsMake(0,0, -17, 0)
        
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
    
    func mapViewDidFinishRenderingMap(mapView: MGLMapView, fullyRendered: Bool) {
        if fullyRendered{
            locationManager.startUpdatingLocation()
        }
    }
    
//    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
//        return true
//    }

}

