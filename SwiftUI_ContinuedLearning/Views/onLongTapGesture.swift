//
//  LongPressGesture.swift
//  SwiftUIContunuedLearning
//
//  Created by Seogun Kim on 2021/05/20.
//

import SwiftUI

struct LongPressGesture: View {
    @State var isCompleted: Bool = false
    @State var isSuccess: Bool = false
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(height: 55)
                .frame(width: isCompleted ? .infinity : 0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack(spacing: 20) {
                Text("2초간 유지")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.cornerRadius(10))
                    .onLongPressGesture(minimumDuration: 1.5, maximumDistance: 50) { (isPressed) in
                        if isPressed {
                            withAnimation(.easeInOut(duration: 1.5)) {
                                isCompleted = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.spring()) {
                                        isCompleted = false
                                    }
                                }
                            }
                        }
                        
                    } perform: {
                        withAnimation(.spring()) {
                            isSuccess = true
                        }
                    }
                
                
                Text("리셋")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.cornerRadius(10))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isCompleted = false
                            isSuccess = false
                        }
                    }
            }
            .padding()
        }
        
        // ontapGesture  튜토리얼
        
        //            Text(isCompleted ? "상태 : 활성화" : "상태 : 비활성화" )
        //                .font(Font.headline.bold())
        //                .padding()
        //                .background(isCompleted ? Color.yellow : Color.gray)
        //                .foregroundColor(isCompleted ? Color.black : Color.white)
        //                .cornerRadius(10)
        
        // tapGuesture type :
        /*
         // 1) .onTapGesture
         //                .onTapGesture {
         //                    isCompleted.toggle()
         //                }
         
         // 2 - 1) .onLongPressGeuture
         //                .onLongPressGesture {
         //                    isCompleted.toggle()
         //                }
         
         // 2 - 2)  .onLongPressGesture(minimumDuration: Double)
         //                .onLongPressGesture(minimumDuration: 2.0) {
         //                    isCompleted.toggle()
         //                }
         
         // 2 - 3)  .onLongPressGesture(maximumDistance: CGFloat)
         // maxiumDistance : n포인트 범위 안에 클릭을 한 상태면 탭제스쳐 활성화
         //                .onLongPressGesture(minimumDuration: 2.0, maximumDistance: 50) {
         //                    isCompleted.toggle()
         //                }
         
         */
        
    }
}

struct LongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesture()
    }
}
