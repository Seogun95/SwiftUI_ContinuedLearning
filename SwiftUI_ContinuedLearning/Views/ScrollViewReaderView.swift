//
//  ScrollViewReaderView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/22.
//

import SwiftUI

struct ScrollViewReaderView: View {
    //1.
    @State var textFieldTitle: String = ""
    @State var ScrollTopIndex: Int = 0
    var body: some View {
          
                VStack {
                    //2.
                    TextField("찾으실 Index를 입력해주세요.", text: $textFieldTitle)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .padding(.vertical, 10)
                        .keyboardType(.numberPad)
        
                    //3.
                    /* ScrollViewReader안에 있는 proxy를 엑세스 할 수 없기 때문에
                     변수를 따로 만들어 줘야 합니다. */
                    Button("\(textFieldTitle.isEmpty ? "? " : (textFieldTitle)) 번 으로 이동") {
                        withAnimation(.spring()) {
                            if let index = Int(textFieldTitle) {
                                ScrollTopIndex = index
                            }
                        }
                    }
        
                  //4.
                    ScrollView {
                        ScrollViewReader { proxy in
                            ForEach(0..<50) { index in
                                Text("아이템 #\(index)")
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                                    .padding()
                                    //5.
                                    //id를 부여해줘야 한다.
                                    .id(index)
                            }
                            //6.
        
                            .onChange(of: ScrollTopIndex, perform: { value in
                                withAnimation(.spring()) {
                                    proxy.scrollTo(value, anchor: .center)
                                }
                            })
        
                        }
                    }
                }
    }
}

struct ScrollViewReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderView()
    }
}
