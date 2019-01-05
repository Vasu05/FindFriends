//
//  PostLocationConfirmationVC.swift
//  FindFriends
//
//  Created by vasu on 04/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import UIKit
import MapKit

class PostLocationConfirmationVC: UIViewController {

    @IBOutlet weak var mMapView: MKMapView!
    @IBOutlet weak var finishBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var localSearchResponse:MKLocalSearch.Response?
    var searchlocation:String?
    var mediaURL:String?
    
    var pointAnnotation : MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        showHideloader(show: false)
    }
    
    func configureUI(){
        finishBtn.layer.cornerRadius = 4.0
          pointAnnotation = MKPointAnnotation()
         pointAnnotation.title = searchlocation ?? ""  //mapItems[0].name ?? "gulabi"
          pointAnnotation.coordinate = CLLocationCoordinate2D(latitude:localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
        
        
        pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
        mMapView.centerCoordinate = self.pointAnnotation.coordinate
        mMapView.addAnnotation(pinAnnotationView.annotation!)
        self.navigationController?.navigationBar.topItem?.title = "Add Location"
    }

    
    @IBAction func finishBtnPressed(_ sender: Any) {
        
        let dataobj = StudentDetailsRequest.init(uniqueKey: "2342", firstName: "Testing", lastName: "Account", mapString: searchlocation, mediaURL: mediaURL, latitude:localSearchResponse!.boundingRegion.center.latitude , longitude: localSearchResponse!.boundingRegion.center.longitude)
      
        showHideloader(show: true)
        
        Engine.postUserLocation(dataobj: dataobj) {
            (success, error) in
            self.showHideloader(show: false)
            if success{
                print("Successfully posted")
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: StudentsMapLocationVC.self) || controller.isKind(of: StudentDetailsVC.self) {
                        _ =  self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
            else{
                print("Error Occured \(error!.localizedDescription)")
            }
        }
        
    }
    func showHideloader(show :Bool){
        
        if show {
            activityIndicator.isHidden =  false
            activityIndicator.startAnimating()
        }
        else{
            activityIndicator.isHidden =  true
            activityIndicator.stopAnimating()
        }
    }
    
}
