//
//  GeometryReaderView2.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/22.
//

import SwiftUI

struct GeometryReaderView2: View {
    let color : [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<51) { value in
                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(self.color[value % 6])
                            .padding()
                            .rotation3DEffect(
                                Angle(degrees: getPercentage1(geo: proxy)*20),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 200)
                }
            }
        })
        
        
        
        
        
        
        
        
        //        GeometryReader { fullView in
        //            ScrollView(.vertical, showsIndicators: false, content: {
        //                ForEach(0..<51) { index in
        //                    GeometryReader { geo in
        //                        Text("\(index)")
        //                            .font(.title)
        //                            .frame(width: geo.size.width)
        //                            .background(color[index % 6])
        //                            .rotation3DEffect(
        //                                .degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5),
        //                                axis: (x: 0.0, y: 1.0, z: 0.0)
        //
        //                            )
        //                    }
        //                    .frame(height: 40)
        //                }
        //            })
        //        }
    }
    
    func getPercentage1(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
}



struct GeometryReaderView2_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView2()
    }
}
