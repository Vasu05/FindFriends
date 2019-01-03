//
//  StudentsMapLocationVC.swift
//  FindFriends
//
//  Created by vasu on 01/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import UIKit
import MapKit

class StudentsMapLocationVC: UIViewController {

    @IBOutlet weak var mMapView: MKMapView!
    var mAnnotation : [MKPointAnnotation] = []
    var mTableDataSource : [StudentDetailsResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mMapView.delegate = self
        
        if Engine.mDataSource == nil{
            Engine.getUsersLocation { (studentData, error) in
               
                guard studentData != nil else{
                    print("User locations error : \(error?.localizedDescription ?? "errorrr")")
                    return
                }
                self.mTableDataSource = Engine.mDataSource!
                self.configureDataSource()
                
            }
        }
        else{
            mTableDataSource = Engine.mDataSource!
            configureDataSource()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        
        let editImage    = UIImage(named: "plus")!
        let reloadImage  = UIImage(named: "reload")!
        
        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(StudentDetailsVC.didTapEditButton))
        let searchButton = UIBarButtonItem(image: reloadImage,  style: .plain, target: self, action: #selector(StudentDetailsVC.didTapSearchButton))
        
        let logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapEditButton))
        
        self.navigationItem.leftBarButtonItem = logoutBtn
        
        self.navigationItem.rightBarButtonItems = [editButton,searchButton]
        
    }
    @objc func didTapEditButton() {
        
    }
    @objc func didTapSearchButton() {
        
    }
    
    
    func configureDataSource(){
        mAnnotation = [MKPointAnnotation]()
        
        for dictionary in mTableDataSource {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(dictionary.latitude ?? 0.0 )
            let long = CLLocationDegrees(dictionary.longitude ?? 0.0)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName ?? ""
            let last =  dictionary.lastName  ?? ""
            let mediaURL = dictionary.mediaURL ?? ""

            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            mAnnotation.append(annotation)
            // Finally we place the annotation in an array of annotations.
            
        }
        mMapView.addAnnotations(mAnnotation)
    }


}

extension StudentsMapLocationVC : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
   
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
}
