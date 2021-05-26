//
//  MaskView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/24.
//

import SwiftUI

struct MaskView: View {

    @State var rating: Int = UserDefaults.standard.integer(forKey: "ranting_key")
    
    var body: some View {
        ZStack {
            starViews
                .overlay(overlayView).mask(starViews)
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
    private var starViews: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.3)) {
                            rating = index
                            SoundSetting.instance.palysound(sound: .click)
                            HapticsManager.instance.impact(style: .heavy)
                            UserDefaults.standard.set(rating, forKey: "ranting_key")
                        }
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
