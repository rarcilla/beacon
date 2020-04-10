//
//  EarthquakeMain.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-06.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct EarthquakeMain: View {
    var emergency: Emergency
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: EarthquakeBeforeList(emergency: emergency)) {
                    Text("Before")
                }
                NavigationLink(destination: EarthquakeDuringActionList(emergency: emergency)) {
                    Text("During")
                }
                NavigationLink(destination: EarthquakeAfterList(emergency: emergency)) {
                    Text("After")
                }
            }
        .navigationBarTitle("Actions")
        }
    }
}


struct EarthquakeMain_Previews:PreviewProvider {
    static var previews: some View {
        EarthquakeMain(emergency: emergencyData[1])
    }
}
