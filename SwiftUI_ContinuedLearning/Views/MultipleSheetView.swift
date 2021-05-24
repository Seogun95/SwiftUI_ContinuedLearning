//
//  MultipleSheetView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/23.
//

import SwiftUI

//MARK: MODEL

struct RandomModel: Identifiable {
    var id: String = UUID().uuidString
    let title: String
}


// MARK: BODY
struct MultipleSheetView: View {
    @State var seletedView: RandomModel? = nil
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 20) {
                ForEach(0..<31) { index in
                    Button("\(index) 버튼") {
                        seletedView = RandomModel(title: "\(index) 번째 입니다.")
                    }
                }
            }
        })
        .sheet(item: $seletedView) { model in
          someView(seletedView: model)
        }
        
    }
}



//MARK: PREVIEWS
struct MultipleSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetView()
    }
}

struct someView: View {
    let seletedView: RandomModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color("Peach").ignoresSafeArea()
                .overlay(
                    Image(systemName: "xmark")
                        .padding([.horizontal, .top], 20)
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    
                    ,alignment: .topLeading
                    
                )
            
            Text(seletedView.title)
                .font(.title)
                .foregroundColor(.white)
        }
    }
}
