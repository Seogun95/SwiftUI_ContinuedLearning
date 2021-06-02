//
//  BackgroundThreadView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/31.
//

import SwiftUI

//1.
class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
        
        
       
    }
    
    func downloadData() -> [String]  {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
}


struct BackgroundThreadView: View {
    @StateObject var ViewModel = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                Text("Load Data".uppercased())
                    .font(.title)
                    .onTapGesture {
                        ViewModel.fetchData()
                    }
                   
                ForEach(ViewModel.dataArray, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}

struct BackgroundThreadView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadView()
    }
}
