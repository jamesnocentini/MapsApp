//
//  ViewController.swift
//  MapsApp
//
//  Created by James Nocentini on 26/07/2014.
//  Copyright (c) 2014 James Nocentini. All rights reserved.
//

import UIKit

var path = NSBundle.mainBundle().pathForResource("MH17", ofType: "csv")
var url = NSURL(fileURLWithPath: path)
let csv = CSV(contentsOfURL: url)
let headers = csv.rows[0]

class ViewController: UIViewController, GMSMapViewDelegate {
    
    lazy var marker: GMSMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: 10,longitude: 10))
    lazy var camera: GMSCameraPosition = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: 10, longitude: 10), zoom: 2, bearing: CLLocationDirection.abs(0.0), viewingAngle: 0.0)
    lazy var mapView_ = GMSMapView(frame: CGRectZero)
    
    
    @IBOutlet weak var planeCoords: UISlider!
    
    @IBAction func valueChanged(sender: AnyObject) {
        println(self.planeCoords.value)
        var idx = (self.planeCoords.value as NSNumber).integerValue
        var r_idx = 104 - idx
        var pt = csv.rows[r_idx]
        var lat = (pt["lat"]!! as NSString).doubleValue
        var lon = (pt["lon"]!! as NSString).doubleValue
        var coor = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        marker.position = coor
        var pos = GMSCameraPosition(target: coor, zoom: 6, bearing: CLLocationDirection.abs(0.0), viewingAngle: 0.0)
        mapView_.camera = pos
    }
    

    //1. When the camera loads we should focus on Amsterdam
    //2.
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get the last point in .csv file because order is reversed
        var takeoff = csv.rows[104]
        //Convert to double types
        var lat = (takeoff["lat"]!! as NSString).doubleValue
        var lon = (takeoff["lon"]!! as NSString).doubleValue
        var coor = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        var rect = CGRectMake(0, 0, self.view.bounds.width, super.view.bounds.height - 40)
        mapView_.frame = rect
        mapView_.camera = camera
        mapView_.delegate = self
        mapView_.myLocationEnabled = true
        mapView_.mapType = kGMSTypeSatellite
        self.view.addSubview(mapView_)
        
        var position = CLLocationCoordinate2D(latitude: 10, longitude: 10)
        marker.position = position
        marker.title = "Hello World"
        marker.map = mapView_
        marker.position = coor
        
        //Play with path
        var path = GMSMutablePath();
        path.addCoordinate(CLLocationCoordinate2DMake(37.36, -122.0))
        path.addCoordinate(CLLocationCoordinate2DMake(37.45, -122.0))
        path.addCoordinate(CLLocationCoordinate2DMake(37.45, -122.2))
        path.addCoordinate(CLLocationCoordinate2DMake(37.36, -122.2))
        path.addCoordinate(CLLocationCoordinate2DMake(37.36, -122.0))
        
        var rectangle = GMSPolyline(path: path)
        rectangle.map = mapView_;
        
        //Play with the UISlider
        planeCoords.translatesAutoresizingMaskIntoConstraints()
        planeCoords.minimumValue = 0
        planeCoords.maximumValue = 104
        planeCoords.continuous = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        println("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }


}

