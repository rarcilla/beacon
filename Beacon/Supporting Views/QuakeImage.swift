//
//  QuakeImage.swift
//  Beacon
//
//  Created by Mike Powar on 2020-04-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI

struct QuakeImage: View {
    var body: some View {
        GeometryReader { geo in
        Image("wildfire")
        .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width)
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
        }
    }
}

struct QuakeImage_Previews: PreviewProvider {
    static var previews: some View {
        QuakeImage()
    }
}
