//
//  Emergency.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Emergency: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var province: String
    var safePlace: String
    var category: Category
    var plan: String
    var prepare: String
    var act: String
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "Featured"
        case natural = "Natural"
        case contagion = "Contagion"
    }
}
    
extension Emergency {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}



struct Emergency_Previews: PreviewProvider {
    static var previews: some View {
        Text("EmergencyPreviewTest!")
    }
}
