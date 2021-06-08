//
//  backgroundThread.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/06/07.
//

import SwiftUI

class backgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
          
            let newData = self.downLoadData()
            print("Thread 확인 1 : \(Thread.isMainThread)")
            print("Thread 확인 1 : \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Thread 확인 2 : \(Thread.isMainThread)")
                print("Thread 확인 2 : \(Thread.current)")
            }
        }
    }
    
    private func downLoadData() -> [String] {
        var data: [String] = []
        
        for i in 0..<100 {
            data.append("\(i)")
            print(data)
        }
        return data
    }
}

struct backgroundThread: View {
    @StateObject var bvm = backgroundThreadViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 10) {
                Text("Background Thread")
                    .font(Font.title2.bold())
                    .onTapGesture {
                        bvm.fetchData()
                    }
                
                ForEach(bvm.dataArray, id: \.self) { data in
                    Text(data)
                        .font(.headline)
                        .foregroundColor(Color("Peach"))
                }
            }
        }
    }
}

struct backgroundThread_Previews: PreviewProvider {
    static var previews: some View {
        backgroundThread()
    }
}
