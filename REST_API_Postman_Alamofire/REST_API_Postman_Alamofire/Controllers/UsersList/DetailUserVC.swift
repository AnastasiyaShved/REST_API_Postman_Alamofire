//
//  DetailUserVC.swift
//  REST_API_Postman_Alamofire
//
//  Created by Apple on 12.10.23.
//

import UIKit
import CoreLocation
import MapKit

class DetailUserVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
   
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData(user: user)
    
    }
    // MARK: - actions
    @IBAction func openMapbtn(_ sender: Any) { openMapForUserLocation() }
    
    @IBAction func postsBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as! PostsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albumsBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AlbumsAndPhotos", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbumsTVC") as! AlbumsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func todosBtn(_ sender: UIButton) { }
    
    // MARK: - private func
    private func openMapForUserLocation() {
        if let user = user,
           let latitudeString = user.address?.geo?.lat,
           let langitudeString = user.address?.geo?.lng,
           let latitude = Double(latitudeString),
           let langitude = Double(langitudeString) {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: langitude)
            let placeMark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placeMark)
            mapItem.name = user.name
            mapItem.openInMaps(launchOptions: nil)
        }
    }

    private func setData(user:User?) {
        if let user = user {
            nameLbl.text = user.name
            userNameLbl.text = user.username
            emailLbl.text = user.email
            phoneLbl.text = user.phone
            websiteLbl.text = user.website
            if let city = user.address?.city,
               let street = user.address?.street,
               let suite = user.address?.suite,
               let zipcode = user.address?.zipcode {
                addressLbl.text = "\(city)\n\(street)\n\(suite) \(zipcode)"
            } else {
                addressLbl.text = "No address"
            }
        }
    }
}
