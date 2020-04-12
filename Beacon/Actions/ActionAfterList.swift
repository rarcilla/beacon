//
//  EarthquakeAfterList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct ActionAfterList: View {
    var emergency: Emergency
    
    
    var body: some View {
                NavigationView {
            List {
                Text(emergency.afterActions[0].step)
                .listRowBackground(Color("BeaconYellow").opacity(0.75))
                Text(emergency.afterActions[1].step)
                .listRowBackground(Color("BeaconTurquoise").opacity(0.75))
                Text(emergency.afterActions[2].step)
                .listRowBackground(Color("BeaconRed").opacity(0.75))
                Text(emergency.after)
                .foregroundColor(.secondary)
                .font(.subheadline)
                    .fontWeight(.medium)
                    .padding()
            }
            .navigationBarTitle("In the Aftermath")
        }
    }
}

struct ActionAfterList_Previews: PreviewProvider {
    static var previews: some View {
        ActionAfterList(emergency: emergencyData[2])
    }
}
