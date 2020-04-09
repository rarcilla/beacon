//
//  WildfireActions.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-08.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI
struct WildfireActions: View {
    var emergency: Emergency
    var body: some View {
                NavigationView {
                    List{
                        NavigationLink(destination: WildfireBeforeList(emergency: emergency)) {
                            Text("Before")
                        }
                        NavigationLink(destination: WildfireDuringList(emergency: emergency)) {
                            Text("During")
                        }
                        NavigationLink(destination: WildfireAfterList(emergency: emergency)) {
                            Text("After")
                        }
                    }
                .navigationBarTitle("Actions")
                }
            }
        }


struct WildfireActions_Previews: PreviewProvider {
    static var previews: some View {
        WildfireActions(emergency: emergencyData[1])
    }
}

