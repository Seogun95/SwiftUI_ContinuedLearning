//
//  MaskView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/24.
//

import SwiftUI

struct MaskView: View {
    
    @State var rating: Int  = UserDefaults.standard.integer(forKey: "save_rating")
    
    var body: some View {
        ZStack {
            starsView
                .overlay(
                    overlayView
                        .mask(starsView)
                    
                )
        }
        
    }
    
    private var overlayView: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(Color.yellow)
                .frame(width: CGFloat(rating) / 5 * geo.size.width)
        }
        .allowsHitTesting(false)
    }
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { value in
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        rating = value
                        UserDefaults.standard.set(rating, forKey: "save_rating")
                    }
            }
        }
    }
}

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView()
            .previewLayout(.sizeThatFits)
    }
}
