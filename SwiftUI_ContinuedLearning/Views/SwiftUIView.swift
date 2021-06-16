//
//  SwiftUIView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/06/12.
//

import SwiftUI

struct PressentingView: View {
    
    @State var showTerms: Bool = false
    
    var body: some View {
        Button("Show Sheet") {
            showTerms = true
            
        }
        .sheet(isPresented: $showTerms) {
            Sheet()
        }
    }
}
struct Sheet: View {
    @State private var acceptedTherms = false
    var body: some View {
        Form {
            Button("Accept Terms") {
                acceptedTherms = true
            }
        }
//        .interactiveDismissDisabled(!acceptedTherms)
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PressentingView()
    }
}
