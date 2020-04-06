//
//  EmergencyList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-05.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct EmergencyList: View {
    var body: some View {
        NavigationView {
        List(emergencyData) { emergency in
            NavigationLink(destination: EmergUIDetail(emergency: emergency)) {
                EmergencyRow(emergency: emergency)
            }
        }
        .navigationBarTitle(Text("Emergencies"))
        }
    }
}

struct EmergencyList_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyList()
    }
}
