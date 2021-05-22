//
//  GeometryReaderView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/22.
//

import SwiftUI

struct GeometryReaderView: View {
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<30) { _ in
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("Peach"))
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geo)*40),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        })
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
