//
//  CircleImage.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-05.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        GeometryReader { geo in
            self.image
               .resizable()
                   .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width, height: 400)
               .clipShape(Circle())
               .overlay(
                   Circle().stroke(Color.white, lineWidth: 4))
               .shadow(radius: 10)
               }
           }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("wildfire"))
    }
}
