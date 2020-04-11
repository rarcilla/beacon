//
//  WildfireBeforeList.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-08.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//
//
import SwiftUI

struct WildfireBeforeList: View {
    var emergency: Emergency
    
    
    var body: some View {
                NavigationView {
            List {
                Text(emergency.beforeActions[0].step)
                Text(emergency.beforeActions[1].step)
                Text(emergency.beforeActions[2].step)
                Text(emergency.before)
                .foregroundColor(.secondary)
                .font(.subheadline)
                    .padding()
                
            }
            .navigationBarTitle("Be prepared")
        }
    }
}

struct WildfireBeforeList_Previews: PreviewProvider {
    static var previews: some View {
        WildfireBeforeList(emergency: emergencyData[1])
    }
}
