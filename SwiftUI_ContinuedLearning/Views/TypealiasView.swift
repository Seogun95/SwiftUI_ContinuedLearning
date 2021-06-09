


import SwiftUI

//MARK: MODEL
struct FruitModel: Identifiable {
    var id = UUID().uuidString
    let ImageName: String
    let name: String
    let price: Int
    let isFavorite: Bool
}

let Fruits = [
    FruitModel(ImageName: "apple", name: "사과", price: 3000, isFavorite: false),
    FruitModel(ImageName: "Peach", name: "복숭아", price: 2000, isFavorite: true)
]


let character = [
    characterModel(ImageName: "ponyo", name: "포뇨", price: 23000, isFavorite: false),
    characterModel(ImageName: "sosuke", name: "소스케", price: 32000, isFavorite: true)
]

typealias characterModel = FruitModel

//MARK: BODY
struct TypealiasView: View {
    
    var body: some View {
        HStack {
            ItemsRow(item: character[0])
            ItemsRow(item: character[1])
        }
    }
}

struct ItemsRow: View {
    var item: characterModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(item.ImageName)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            
            Text(item.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("Peach"))

            Text("￦\(item.price)")
                .font(Font.title2.weight(.semibold))
            
            if item.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .imageScale(.large)
            } else {
                Image(systemName: "star")
                    .foregroundColor(.gray)
                    .imageScale(.large)
            }
            
        }
    }
}
//MARK: PREVIEWS
struct TypealiasView_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasView()
    }
}
