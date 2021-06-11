//
//  EscapingView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/06/10.
//

import SwiftUI


class EscapingViewModel: ObservableObject {
    @Published var text: String = "안녕하세요"
    
    func getData() {
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
    }
    
    func downloadData() -> String {
        return "서근블로그  입니다."
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("서근블로그 입니다.")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("서근블로그 입니다.")
        }
    }
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "서근블로그 입니다")
            completionHandler(result)
        }
    }
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "서근블로그 입니다")
            completionHandler(result)
        }
    }
    
    struct DownloadResult {
        let data: String
    }
    
    typealias DownloadCompletion = (DownloadResult) -> Void

}

struct EscapingView: View {
    @StateObject var ViewModel = EscapingViewModel()
    
    var body: some View {
        Text(ViewModel.text)
            .font(Font.largeTitle.bold())
            .foregroundColor(.yellow)
            .onTapGesture {
                ViewModel.getData()
            }
    }
}

struct EscapingView_Previews: PreviewProvider {
    static var previews: some View {
        EscapingView()
    }
}
