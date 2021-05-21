//
//  DragGestureView2.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/21.
//

import SwiftUI

struct DragGestureView2: View {
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.87
    @State var currentDrageOffsetY: CGFloat = 0
    @State var endingDrageOffsetY: CGFloat = 0
    var body: some View {
        ZStack {
            Color("Peach").ignoresSafeArea()
            
            
            MySignUpView()
                
                
                .offset(y: startingOffsetY)
                .offset(y: currentDrageOffsetY)
                .offset(y: endingDrageOffsetY)
                .gesture (
                    DragGesture()
                        .onChanged { value in
                            currentDrageOffsetY = value.translation.height
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if currentDrageOffsetY < -150 {
                                    
                                    //서로를 취소시킴
                                    endingDrageOffsetY = -startingOffsetY
                                    currentDrageOffsetY = 0
                                    
                                    //endingOffset이 탑이고, currentOffset이 150보다 크다면
                                } else if endingDrageOffsetY != 0 && currentDrageOffsetY > 150{
                                    endingDrageOffsetY = 0
                                    currentDrageOffsetY = 0
                                }
                                
                                else {
                                    currentDrageOffsetY = 0
                                }
                            }
                        }
                )
            
            
//            Text("\(currentDrageOffsetY)")
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGestureView2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView2()
    }
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "chevron.up")
                .padding(.top, 20)
            Text("회원가입")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image("sample1")
                .resizable()
                .scaledToFit()
                .frame(width: 400)
                .cornerRadius(10)
            Text("SwiftUI에서 Gesture을 활용한 뷰를 꾸미는 것은 정말 재미있고 다양한 방법이 있습니다. 조금 복잡하지만 열심히 배워보도록 하죠!")
                .multilineTextAlignment(.center) .padding()
            
            Text("로그인")
                .font(Font.title3.bold())
                .padding(10)
                .padding(.horizontal, 10)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(10)
            
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
