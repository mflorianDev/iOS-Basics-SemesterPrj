//
//  ViewController.swift
//  MapKit_Mojave
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
        
        /*
        //Constraining the Camera
        let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
        let region = MKCoordinateRegion(
          center: oahuCenter.coordinate,
          latitudinalMeters: 50000,
          longitudinalMeters: 60000)
        mapView.setCameraBoundary(
          MKMapView.CameraBoundary(coordinateRegion: region),
          animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        */
        
        // setting ViewController as the delegate of the map view
        mapView.delegate = self

        /*
        // Show artwork on map
        let artwork = Artwork(
          title: "King David Kalakaua",
          locationName: "Waikiki Gateway Park",
          discipline: "Sculpture",
          coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        mapView.addAnnotation(artwork)
        */
        
        
        // Here, you register your new class with the map view’s default reuse identifier.
        // For an app with more annotation types, you would register classes with custom identifiers.
        mapView.register(
        ArtworkMarkerView.self,
        forAnnotationViewWithReuseIdentifier:
          MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        /*
        // Annotations with Images
        // Here, you register your class "ArtworkView" from ArtworkViews.swift with the map view’s default reuse identifier.
        mapView.register(
        ArtworkView.self,
        forAnnotationViewWithReuseIdentifier:
          MKMapViewDefaultAnnotationViewReuseIdentifier)
        */
        
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
  /*
  // 1
  func mapView(
    _ mapView: MKMapView,
    viewFor annotation: MKAnnotation
  ) -> MKAnnotationView? {
    // 2
    guard let annotation = annotation as? Artwork else {
      return nil
    }
    // 3
    let identifier = "artwork"
    var view: MKMarkerAnnotationView
    // 4
    if let dequeuedView = mapView.dequeueReusableAnnotationView(
      withIdentifier: identifier) as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      // 5
      view = MKMarkerAnnotationView(
        annotation: annotation,
        reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }
  */

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

