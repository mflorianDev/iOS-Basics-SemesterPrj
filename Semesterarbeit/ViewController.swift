//
//  ViewController.swift
//  Semesterarbeit
//
//  Created by macciMac on 04.06.21.
//  Copyright © 2021 macciMac. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    // array to hold the Artwork objects from the GeoJSON file
    private var artworks: [Artwork] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial location in Vienna
        let initialLocation = CLLocation(latitude: 48.205365788495456, longitude: 16.35984682212794)
        mapView.centerToLocation(initialLocation)
        
        // setting ViewController as the delegate of the map view
        mapView.delegate = self
        
        // Here, you register your new class with the map view’s default reuse identifier.
        // For an app with more annotation types, you would register classes with custom identifiers.
        mapView.register(
        ArtworkMarkerView.self,
        forAnnotationViewWithReuseIdentifier:
          MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        // add artwork annotations from array to the map
        loadInitialData()
        mapView.addAnnotations(artworks)
        // Do any additional setup after loading the view.
    }
    
    //  read PublicArt.geojson into a Data object and create artwork object using the failable initializer of Artwork
    private func loadInitialData() {
      // 1
      guard
        let fileName = Bundle.main.url(forResource: "CITYBIKEOGD", withExtension: "json"),
        let artworkData = try? Data(contentsOf: fileName)
        else {
          return
      }

      do {
        // 2
        let features = try MKGeoJSONDecoder()
          .decode(artworkData)
          .compactMap { $0 as? MKGeoJSONFeature }
        // 3
        let validWorks = features.compactMap(Artwork.init)
        // 4
        artworks.append(contentsOf: validWorks)
      } catch {
        // 5
        print("Unexpected error: \(error).")
      }
    }

    @IBAction func mapTypeSelection(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
            case 0:
                mapView.mapType = .standard
            case 1:
                mapView.mapType = .satellite
            case 2:
                mapView.mapType = .hybrid
            default:
                mapView.mapType = .standard
        }
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension ViewController: MKMapViewDelegate {
  // tell MapKit what to do when the user taps the callout button
  func mapView(
    _ mapView: MKMapView,
    annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl
  ) {
    guard let artwork = view.annotation as? Artwork else {
      return
    }

    let launchOptions = [
      MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
    ]
    artwork.mapItem?.openInMaps(launchOptions: launchOptions)
  }

}

