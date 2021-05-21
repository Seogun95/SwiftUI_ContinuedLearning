//
//  DragGestureView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/21.
//

import SwiftUI

struct DragGestureView: View {
    @State var isDragging: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(isDragging.width, specifier: "%.2f")")
                Spacer()
            }
            
            Image("sample1")
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 250)
                .cornerRadius(10)
                .offset(isDragging)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                isDragging = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                isDragging = .zero
                            }
                        }
                )
        }
    }
    
    func getScaleAmount() -> CGFloat {
        //오른쪽 또는 왼쪽으로 이동 가능한 최대 width
        //즉, 오/왼쪽 끝 중앙까지만 가능하다는 의미
        let max = UIScreen.main.bounds.width / 2
        //오른쪽 왼쪽만 추척 하기때문에 with
        let currentAmount = abs(isDragging.width)
        let percentage = currentAmount / max
        //        return 1.0 - percentage
        
        // 0.5를 곱해서 속도를 늦춤
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = isDragging.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

struct DragGestureView_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
