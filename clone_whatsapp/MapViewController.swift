//
//  MapViewController.swift
//  clone_whatsapp
//
//  Created by Devashish Ghanshani on 03/07/24.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    let apiKey = Keys.apiKey
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints to the mapView to fill the parent view
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        placesClient = GMSPlacesClient.shared()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            
            manager.startUpdatingLocation()
            
            let coordinates = CLLocationCoordinate2D(latitude: manager.location?.coordinate.latitude ?? 0.0, longitude: manager.location?.coordinate.longitude ?? 0.0)
            
            let camera = GMSCameraPosition(latitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15.0)
            mapView.camera = camera
            
//            let marker = GMSMarker()
//            marker.position = coordinates
//            marker.title = "Your Location"
//            marker.snippet = "India"
//            marker.map = mapView
            
            fetchNearbyPlaces(coordinate: coordinates)
        }
    }
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        
        let radius = 1000.0 // Radius in meters
//        let type = "restaurant"
            
        let location = "\(coordinate.latitude),\(coordinate.longitude)"
            
        // Create URL for nearby search request
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location)&radius=\(radius)&key=\(apiKey)"
            
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
            
        // Fetch nearby places
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(String(describing: error))")
                return
            }
                
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let results = json["results"] as? [[String: Any]] {
                    DispatchQueue.main.async {
                        self.addMarkers(places: results)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
            
        task.resume()
    }
        
    func addMarkers(places: [[String: Any]]) {
        for place in places.prefix(10) {
            if let geometry = place["geometry"] as? [String: Any],
                let location = geometry["location"] as? [String: Any],
                let lat = location["lat"] as? CLLocationDegrees,
                let lng = location["lng"] as? CLLocationDegrees,
                let name = place["name"] as? String,
                let vicinity = place["vicinity"] as? String {
                    
                let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let marker = GMSMarker(position: position)
                marker.title = name
                marker.snippet = vicinity
                marker.map = mapView
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        case .denied:
            return
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }

}
