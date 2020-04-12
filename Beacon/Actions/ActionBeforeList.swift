//
//  EarthquakeBeforeList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//
import SwiftUI

struct ActionBeforeList: View {
    var emergency: Emergency
    
    
    var body: some View {
        NavigationView {
            List {
                Text(emergency.beforeActions[0].step)
                .listRowBackground(Color("BeaconRed").opacity(0.75))
                Text(emergency.beforeActions[1].step)
                .listRowBackground(Color("BeaconYellow").opacity(0.75))
                Text(emergency.beforeActions[2].step)
                .listRowBackground(Color("BeaconTurquoise").opacity(0.75))
                Text(emergency.before)
                .foregroundColor(.secondary)
                .font(.subheadline)
                .fontWeight(.medium)
                    .padding()
                
            }
            .navigationBarTitle("Be prepared")
        }
    }
}

struct ActionBeforeList_Previews: PreviewProvider {
    static var previews: some View {
        ActionBeforeList(emergency: emergencyData[0])
    }
}
