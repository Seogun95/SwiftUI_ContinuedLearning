//
//  ScrollViewRe.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/22.
//

import SwiftUI

struct ScrollViewRe: View {
    
    let photos: [String] = ["sample1", "sample2", "sample3"]
    
    var body: some View {
        
        ScrollView {
            ScrollViewReader { proxy in
                VStack(spacing: 20) {
                    ForEach(0..<50) { value in
                        Image(self.photos[value % 3])
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .id(value)
                    }
                    .padding(10)
                }
            }
        }
    }
}


struct ScrollViewRe_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewRe()
    }
}
