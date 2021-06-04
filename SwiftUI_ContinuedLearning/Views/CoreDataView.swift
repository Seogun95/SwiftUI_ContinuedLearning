//
//  CoreDataView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/06/04.
//

import SwiftUI
import CoreData

// MVVM 아키텍처
// Model - data point
// View - UI
// View Model - View의 데이터를 관리해준다.

// View뒤에는 실제로 모든 데이터를 보유/관리 하는 View Model이 존재함.



class CoreDataViewModel: ObservableObject {
    
    @Published var savedEntities: [FruitEntity] = []
    
    // coreData import필수
    ///NSPersistentContainer는  Core Data 스택의 생성 및 관리를 단순화합니다
    let container: NSPersistentContainer
    
    init() {  
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data를 로딩하는데 실패했습니다. \(error)")
            } else {
                print("Core data를 로드하는데 성공했습니다.")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        //let request = NSFetchRequest(entityName: "FruitEntity") 에서는 반드시 제네릭을 사용해야 합니다. 제네릭을 사용하지 않으면 컴파일 오류가 생깁니다. (Xcode 재부팅 필요)
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        //request로 요청을 받았으므로 호출을 해야함
        do {
            //이 데이터를 실제로 가져올 때 넣을 위치는 @Published로 정해줘야함
            // try container.viewContext.fetch(request)
            savedEntities =  try container.viewContext.fetch(request)
        } catch let error {
            print("fetching 애러. \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newItems = FruitEntity(context: container.viewContext)
        newItems.name = text
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("saving 애러. \(error)")
        }
    }
    
    func updateItem(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
}

struct CoreDataView: View {
    @StateObject var coreDataViewModel = CoreDataViewModel()
    @State var textFieldtitle: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("추가할 과일을 입력해주세요.", text: $textFieldtitle)
                    .font(.headline)
                    .frame(height: 60)
                    .padding(.horizontal, 10)
                    .background(Color(UIColor.secondarySystemBackground).cornerRadius(10))
                    .padding(.horizontal, 10)
                    .disableAutocorrection(true)
                
                Button(action: {
                    //현재 textFieldtitle은 빈문자열 이므로 하나의 문자가 있는지 확인하려면 guard let을 사용하는것이 좋다.
                    
                    //textField가 비어있지 않은경우 실행
                    guard !textFieldtitle.isEmpty else {return}
                    coreDataViewModel.addFruit(text: textFieldtitle)
                    textFieldtitle = ""
                    
                }, label: {
                    Text("버튼")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color("Peach").cornerRadius(10))

                })
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "scribble.variable")
                    Text("저장된 과일 목록")
                    
                }
                .font(Font.title2.bold())
                .padding(.top, 20)
                .padding(.horizontal, 20)
                
                
                List {
                    
                    ForEach(coreDataViewModel.savedEntities) { entity in
                        //name이 옵셔널 이기 때문에 ?? 마크
                        HStack {
                            Image(systemName: "checkmark")
                            Text(entity.name ?? "데이터 없음")
                                .onTapGesture {
                                    coreDataViewModel.updateItem(entity: entity)
                                }
                        }
                      
                    }
                    .onDelete(perform: coreDataViewModel.deleteItem)
                   
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("과일")
        }
    }
}

struct CoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataView()
    }
}
