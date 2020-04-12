//
//  EarthquakeMain.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct ActionMain: View {
    var emergency: Emergency
    
    var body: some View {
            List{
                NavigationLink(destination: ActionBeforeList(emergency: emergency)) {
                    Text("Before")
                }.listRowBackground(Color("BeaconRed").opacity(0.75))
                NavigationLink(destination: ActionDuringList(emergency: emergency)) {
                    Text("During")
                }.listRowBackground(Color("BeaconYellow").opacity(0.75))
                NavigationLink(destination: ActionAfterList(emergency: emergency)) {
                    Text("After")
                }.listRowBackground(Color("BeaconTurquoise").opacity(0.75))
            }
        .navigationBarTitle("Actions")
    }
}


struct ActionMain_Previews:PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActionMain(emergency: emergencyData[1])
        }
    }
}
