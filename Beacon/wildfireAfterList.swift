//
//  wildfireAfterList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-08.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct WildfireAfterList: View {
    var emergency: Emergency
    
    
    var body: some View {
                NavigationView {
            List {
                Text(emergency.after)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .padding()
                Text(emergency.afterActions[0].step)
                Text(emergency.afterActions[1].step)
                Text(emergency.afterActions[2].step)
                
                
            }
            .navigationBarTitle("In the Aftermath")
        }
    }
}

struct WildfireAfterList_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeAfterList(emergency: emergencyData[1])
    }
}
