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
        VStack {
            starViews
                .overlay(overlayView).mask(starViews)
            
            Image("sample2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .mask(
                    ZStack {
                        Circle()
                            .frame(width: 208, height: 208)
                        Circle()
                            .frame(width: 90, height: 90)
                            .offset(x: 80, y: 55)
                    }
                )
                .frame(height: 300)
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
                            UserDefaults.standard.set(rating, forKey: "ranting_key")
                            SoundSetting.instance.palysound(sound: .click)
                            HapticsManager.instance.notification(type: .success)
                        }
                    }
            }
            
        }
    }
}

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView()
        
    }
}
