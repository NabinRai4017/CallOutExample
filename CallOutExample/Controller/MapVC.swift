//
//  MapVC.swift
//  CallOutExample
//
//  Created by nabinrai on 6/27/17.
//  Copyright © 2017 nabin. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let calloutView = BezierView()
    
    
    // ViewController lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        demoLocation()
    }
    
    
    
    
    // Methods
    
    func demoLocation(){
        let location = CLLocationCoordinate2D(latitude: 27.7172, longitude: 85.3240)
        let location1 = CLLocationCoordinate2D(latitude: 27.71, longitude: 85.32)
        let center = location
        let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
        mapView.setRegion(region, animated: true)
        addRestaurentOnLocation(location: location)
        addRestaurentOnLocation(location: location1)
    }
    
    func addRestaurentOnLocation(location:CLLocationCoordinate2D){
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = location
        mapView.addAnnotation(pointAnnotation)
    }
    
    
}



extension MapVC: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            
            return nil
        }else {
            let reuseIdentifier = "pin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                
            } else {
                annotationView?.annotation = annotation
            }
            annotationView?.image = UIImage(named: "map_marker")
           
            return annotationView
        }

    }
    
    
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]){
        for view in views {
            view.canShowCallout = false
        }
    }
    
    
    func mapView(_ mapView: MKMapView,didSelect view: MKAnnotationView)
    {
        if view.annotation is MKUserLocation
        {
            return
        }
        calloutView.msgLabel.text = "Hi this is my Demo"
        calloutView.bubbleDirection = .leftUp
        calloutView.bubbleRadiusMultiplier = 0.9
        calloutView.manageBubbleView(view: view)
      
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        calloutView.removeFromSuperview()
    }
    
    
    
}

