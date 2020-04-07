//
//  Home.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-05.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//


import SwiftUI

struct CategoryHome: View {
    var categories: [String: [Emergency]] {
        Dictionary(
            grouping: emergencyData,
            by: { $0.category.rawValue }
        )
    }
    
    
    var featured: [Emergency] {
        emergencyData.filter { $0.isFeatured }
    }
    
    var body: some View {
        NavigationView {
            List {
                FeaturedEmergencies(emergencies: featured)
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .listRowInsets(EdgeInsets())

                    ForEach(categories.keys.sorted(), id: \.self) { key in
                        CategoryRow(categoryName: key, items: self.categories[key]!)
                            }
                            .listRowInsets(EdgeInsets())
                
                        NavigationLink(destination: EmergencyList()) {
                                Text("See All")
                            }
                        }
            .navigationBarTitle(Text("In Focus"))
        }
    }
}


struct FeaturedEmergencies: View {
    var emergencies: [Emergency]
    var body: some View {
        emergencies[0].image.resizable()
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
