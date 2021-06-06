//
//  Artwork.swift
//  Semesterarbeit
//
//  Created by macciMac on 04.06.21.
//  Copyright © 2021 macciMac. All rights reserved.
//

import Foundation
import MapKit
import Contacts


class Artwork: NSObject, MKAnnotation {
  let district: Int?
  let title: String?
  let coordinate: CLLocationCoordinate2D
  
  /*
  init(
    station: String?,
    district: Int?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.station = station
    self.district = district
    self.coordinate = coordinate
    self.title = station
    super.init()
  }
  */

  // Decoding GeoJSON with MKGeoJSONDecoder and return an array of objects
  init?(feature: MKGeoJSONFeature) {
    // 1
    guard
      let point = feature.geometry.first as? MKPointAnnotation,
      let propertiesData = feature.properties,
      let json = try? JSONSerialization.jsonObject(with: propertiesData),
      let properties = json as? [String: Any]
      else {
        return nil
    }

    // 3
    district = properties["BEZIRK"] as? Int
    title = properties["STATION"] as? String
    coordinate = point.coordinate
    super.init()
  }


  /*
  var subtitle: String? {
    return "Citybike-Station"
  }
  */

    
  // create MKMapItem's to pass them to Maps App
  // first create placemarks and then mapitems
  var mapItem: MKMapItem? {
    guard let location = title else {
        return nil
    }
    let addressDict = [CNPostalAddressStreetKey: location]
    let placemark = MKPlacemark(
        coordinate: coordinate,
        addressDictionary: addressDict)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    return mapItem
    }
    
  // change marker-color by property discipline
  var markerTintColor: UIColor  {
    switch district {
    case 1, 12:
      return .red
    case 4, 13, 18:
      return .green
    case 6, 16, 20:
      return .blue
    case 7, 19:
      return .cyan
    case 8, 22:
      return .yellow
    case 9, 15, 23:
      return .magenta
    case 2:
      return .orange
    case 3, 17:
      return .purple
    case 5, 14, 21:
      return .brown
    default:
      return .gray
    }
  }
    
    // set the glyph’s image instead of its text
    var image: UIImage {
        return #imageLiteral(resourceName: "Citybike")
    }


    /*
    // set the glyph’s image instead of its text
    var image: UIImage {
      guard let name = discipline else {
        return #imageLiteral(resourceName: "Flag")
      }

      switch name {
      case "Monument":
        return #imageLiteral(resourceName: "Monument")
      case "Sculpture":
        return #imageLiteral(resourceName: "Sculpture")
      case "Plaque":
        return #imageLiteral(resourceName: "Plaque")
      case "Mural":
        return #imageLiteral(resourceName: "Mural")
      default:
        return #imageLiteral(resourceName: "Flag")
      }
    }
    */

}
