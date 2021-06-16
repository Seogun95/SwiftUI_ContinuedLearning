//
//  DownloadWithEscaping.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/06/16.
//

import SwiftUI


// jsonString에 대한 모델 생성
//get post 1의 Json 데이터와 동일한 모델 생성
// postModel을 디코딩하고 인코딩을 원하기 때문에 codable 추가
struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject {
    
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        //URL을 만들때는 옵셔널 이기 때문에 guard let 사용
        //7. 실제로 다운로드해야 할 URL이 필요. fake API JSON 사이트 https://jsonplaceholder.typicode.com/
        //가져온 JSON : Routes -> get post 1
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        

        
        downloadData(formURL: url) { retrunedData in
            if let data = retrunedData {
                
                guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.posts.append(newPost)
                }
            } else {
                print("반환할 데이터가 존재하지 않습니다.")
            }
        }
        
    }
}

//escaping downloadData함수 생성
func downloadData(formURL url: URL, completionHandler: @escaping (_ data: Data?) -> () ) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let data = data,
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            print("다운로드 에러")
            completionHandler(nil)
            return
        }
        completionHandler(data)
    }
    //start function. 위 코드가 실행되기 전까지 실행되지 않는다.
    .resume()
}

struct DownloadWithEscaping: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack {
                    Text(post.title)
                        .font(Font.title.bold())
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct DownloadWithEscaping_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscaping()
    }
}
