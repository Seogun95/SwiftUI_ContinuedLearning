//
//  RotationGestureView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/21.
//

import SwiftUI

struct RotationGestureView: View {
    @State var angle: Angle = Angle(degrees: 0)
    var body: some View {
        Image("sample1")
            .resizable()
            .renderingMode(.original)
            .frame(width: 250, height: 200)
            
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

struct RotationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureView()
    }
}
