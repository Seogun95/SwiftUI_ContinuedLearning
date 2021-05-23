//
//  MultipleSheetView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/23.
//

import SwiftUI

// MARK: MODEL
struct RandomModel: Identifiable {
    let id: String = UUID().uuidString
    var title: String
}


// MARK: BODY
struct MultipleSheetView: View {
    
    //sheet의 item을 사용하기위해 옵셔널 바인딩이 필요하다.
    @State var seletedModel: RandomModel? = nil
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 10) {
                ForEach(0..<51) { index in
                    Button("\(index) 버튼") {
                        seletedModel = RandomModel(title: "\(index)")
                    }
                }
            }
        })
            .sheet(item: $seletedModel) { model in
                SomeScreen(seletedModel: model)
            }
    }
}


//MARK: SECOND VIEW
struct SomeScreen: View {
    let seletedModel: RandomModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color("Peach").ignoresSafeArea()
            
            Text(seletedModel.title)
                .foregroundColor(Color.white)
                .font(.title)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            
        }
    }
}


//MARK: PREVIEWS
struct MultipleSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetView()
    }
}
