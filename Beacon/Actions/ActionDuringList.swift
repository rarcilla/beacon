//
//  ActionDuringList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct ActionDuringList: View {
    var emergency: Emergency
    
    
    var body: some View {
                NavigationView {
            List {
                Text(emergency.duringActions[0].step)
                .listRowBackground(Color("BeaconRed").opacity(0.75))
                Text(emergency.duringActions[1].step)
                .listRowBackground(Color("BeaconYellow").opacity(0.75))
                Text(emergency.duringActions[2].step)
                .listRowBackground(Color("BeaconTurquoise").opacity(0.75))
                Text(emergency.during)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding()
                
            }
            .navigationBarTitle("During")
        }
    }
}

struct EarthquakeDuringActionList_Previews: PreviewProvider {
    static var previews: some View {
        ActionDuringList(emergency: emergencyData[0])
    }
}
