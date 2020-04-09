//
//  Emergency.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Emergency:  Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var subtitle: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var province: String
    var city: String
    var safePlace: String
    var category: Category
    var isFavorite: Bool
    var isFeatured: Bool
    var generalInfo: String
    var regionalInfo: String
    var before: String
    var during: String
    var after: String
    
    var beforeSteps: Steps
    var duringSteps: Steps
    var afterSteps: Steps
    
    var beforeActions: [Action]
    var duringActions: [Action]
    var afterActions: [Action]
    
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

struct Action: Hashable, Codable {
    var step: String
}

//struct ActionSet: Hashable, Codable {
//    struct ActionStep: Hashable, Codable {
//        var step: String
//    }
//
//    var actionSet: [ActionStep]
//}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}


struct Steps: Hashable, Codable {
    var first, second, third: String
}

struct Emergency_Previews: PreviewProvider {
    static var previews: some View {
        Text("EmergencyPreviewTest!")
    }
}
