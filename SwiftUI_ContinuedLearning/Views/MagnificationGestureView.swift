//
//  MaginificationGestureView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/20.
//

import SwiftUI

struct MagnificationGestureView: View {
    @State var currentAmount: CGFloat = 0
//    @State var lastAmount: CGFloat = 1

    var body: some View {
       
        VStack(spacing: 10) {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                Text("@Seogun")
                Spacer()
            }
            .padding(.horizontal)

           Image("sample1")
            .resizable()
            .renderingMode(.original)
            .scaledToFit()
            .scaleEffect(1 + currentAmount)
            .gesture(
             MagnificationGesture()
                .onChanged { value in
                    currentAmount = value - 1
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        currentAmount = 0
                    }
                }
            )


            HStack {
            Image(systemName: "heart")
                .foregroundColor(Color("Peach"))
            Image(systemName: "text.bubble")
                .foregroundColor(Color.gray)
                Spacer()
            }
            .font(Font.headline.bold())
            .padding([.top, .bottom], 10)
            .padding(.horizontal)


            Text("오늘은 SwiftUI의 MagnificationGesture에 대해 알아보았다.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }

        
        
//
//        Image("sample1")
//            .resizable()
//            .renderingMode(.original)
//            .scaledToFit()
//            .scaleEffect(currentAmount + lastAmount)
//            .gesture(
//             MagnificationGesture()
//                .onChanged { value in
//                    currentAmount = value - 1
//                }
//                .onEnded { value in
//                    lastAmount += currentAmount
//                    currentAmount = 0
//                }
//            )
    }
}

struct MaginificationGestureView_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureView()
    }
}
