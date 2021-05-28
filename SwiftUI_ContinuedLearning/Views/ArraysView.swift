//
//  ArraysView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/28.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let score: Int
    let isfavorite: Bool
}

class ArraysViewModel: ObservableObject {
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    //3-1
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        UpdateFilteredArray()
    }
    
    func UpdateFilteredArray() {
        
        //1. sort
        /*
         filteredArray = dataArray.sorted(by: { $0.score > $1.score})
         */
        
        //2. filter
        
        // 첫 번째 방법
        /*
         filteredArray = dataArray.filter({ user in
         return user.isfavorite
         //            return user.score > 50
         //            return user.name.contains("서")
         })
         */

        // 두 번째 방법
        /*
         //        filteredArray = dataArray.filter({ $0.score > 50})
         //        filteredArray = dataArray.filter({ $0.isfavorite})
         filteredArray = dataArray.filter({ !$0.isfavorite})
         //        filteredArray = dataArray.filter({ $0.name.contains("서")})
         */

        //3. map
        
        // 첫 번째 방법
        /*
        mappedArray = dataArray.map({ (user) -> String in
            return user.name
        })
        */
        
        // 두 번째 방법
        /*
        mappedArray = dataArray.map({$0.name})
        */
 
        // 만약 userModel name이 옵셔널이고 nil을 포함하고 있다면?
        /*
        mappedArray = dataArray.compactMap({ (user) -> String? in
            return user.name
        })
        */
        
         //mappedArray = dataArray.compactMap({$0.name})
        
    
        //4. 활용하기
        
        mappedArray = dataArray
            .sorted(by: {$0.name > $1.name})
            .filter({$0.isfavorite})
            .compactMap({$0.name})
       
        /*
        filteredArray = dataArray
            .sorted(by: {$0.score > $1.score})
            .filter({$0.score > 20})
            .filter({$0.isfavorite})
          */
        
        
    }
    
    func getUsers() {
        let user = [
            UserModel(name: "서근", score: 100, isfavorite: true),
            UserModel(name: "학진", score: 20, isfavorite: false),
            UserModel(name: "시영", score: 10, isfavorite: true),
            UserModel(name: "보경", score: 80, isfavorite: true),
            UserModel(name: "상진", score: 30, isfavorite: false),
            UserModel(name: "애경", score: 31, isfavorite: true),
            UserModel(name: "이지", score: 60, isfavorite: false),
            UserModel(name: "다슬", score: 2, isfavorite: true),
            UserModel(name: "서경", score: 33, isfavorite: true),
            UserModel(name: "보미", score: 25, isfavorite: false)
        ]
        dataArray.append(contentsOf: user)
    }
}


struct ArraysView: View {
    @StateObject var arraysViewModel: ArraysViewModel = ArraysViewModel()
    var body: some View {
        
        //3-2. map 에 사용
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10){
                ForEach(arraysViewModel.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.headline)
                }
            }
        }
        
        
        //1. sort , 2. filter 에 사용
        /*
        ScrollView {
            VStack {
                ForEach(arraysViewModel.filteredArray) { items in
                    VStack(alignment: .leading, spacing: 20) {
                        Text(items.name)
                            .font(Font.headline.weight(.black))
                        
                        HStack {
                            Text("점수 :") +
                                Text("  \(items.score)")
                                .foregroundColor(items.score > 70 ? Color.red : .black)
                                .fontWeight(items.score > 70 ? .bold : .medium)
                            
                            Spacer()
                            if items.isfavorite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                                    .padding(1)
                                    .overlay(Circle().stroke(lineWidth: 1.0).fill(Color.yellow))
                                
                            }
                        }
                    }
                }
                .padding()
                .background(Color("Peach").cornerRadius(20).opacity(0.8))
                .padding(.horizontal)
            }
        }
        */
        
    }
}

struct ArraysView_Previews: PreviewProvider {
    static var previews: some View {
        ArraysView()
    }
}
