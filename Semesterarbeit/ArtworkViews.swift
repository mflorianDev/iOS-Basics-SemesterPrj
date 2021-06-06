//
//  ArtworkViews.swift
//  Semesterarbeit
//
//  Created by macciMac on 04.06.21.
//  Copyright © 2021 macciMac. All rights reserved.
//

import Foundation
import MapKit

// replace annotations and pass new color properties
class ArtworkMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let artwork = newValue as? Artwork else {
        return
      }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      //rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
      // Change the right callout accessory info button, so when clicked it shows the Maps icon.
      let mapsButton = UIButton(frame: CGRect(
        origin: CGPoint.zero,
        size: CGSize(width: 48, height: 48)))
      mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
      rightCalloutAccessoryView = mapsButton
        
      // Generate a multi-line label for the detail callout accessory.
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(12)
      detailLabel.text = "Citybike-Station"
      if let _district = artwork.district {detailLabel.text! += "\nDistrict: " + String(_district)} else {}
      detailLabel.text! += "\nCoordinates: " + String(artwork.coordinate.latitude) + ", " + String(artwork.coordinate.longitude)
      detailCalloutAccessoryView = detailLabel

      // 2
      markerTintColor = artwork.markerTintColor
      glyphImage = artwork.image
      /*
      if let letter = artwork.discipline?.first {
        glyphText = String(letter)
      }
      */
    }
  }
}

/*
// using an MKAnnotationView instead of an MKMarkerAnnotationView, and the view has an image property.
class ArtworkView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let artwork = newValue as? Artwork else {
        return
      }

      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      
      /*
      // Change the right callout accessory info button, so when clicked it shows the Maps icon.
      let mapsButton = UIButton(frame: CGRect(
        origin: CGPoint.zero,
        size: CGSize(width: 48, height: 48)))
      mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
      rightCalloutAccessoryView = mapsButton
      */
        
      image = artwork.image
        
      // Generate a multi-line label for the detail callout accessory.
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(12)
      detailLabel.text = artwork.subtitle
      detailCalloutAccessoryView = detailLabel

    }
  }
}
*/
