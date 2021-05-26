//
//  SoundsView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/25.
//

import SwiftUI
//2. AVKit를 Import
import AVKit


//MARK: SOUNDSETTING
class SoundSetting {
    //1. soundSetting의 단일 인스턴스를 만듬
    static let instance = SoundSetting()
    /// singleton ? :
    /*싱글 톤은 한 번만 생성 된 다음 사용해야하는 모든 곳에서 공유해야하는 객체입니다 */
    
    //3. 음악을 재생하기위한 변수를 생성 (옵셔널 타입)
    var player: AVAudioPlayer?
    
    // 5. 4-3에서 한개만 사용 가능한것을 enum을 사용하여 여러 옵션을 생성한다.
    enum SoundOption: String {
        case click
        case knock
    }
    
    
    //4. 함수 생성
    // func palysound() {
    //6. SoundOption을 platsound에 전달해준다.
    func palysound(sound: SoundOption) {
        
        //우리는 URL을 사용하지 않고 Bundle을 사용하기 때문에 아래 코드는 주석처리
        //guard let url = URL(string: "") else {return}
        //4 - 3
        // guard let url = Bundle.main.url(forResource: "click", withExtension: ".mp3") else {return}
        
        //7. click -> sound.rawValue로 수정
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        
      //4 - 4 do {} 감싸준후 catch let error 코드 생성
        do {
            //4 - 2
            player = try AVAudioPlayer(contentsOf: url)
            //player가 옵셔널이지만 파일이 있다면 옵셔널이 아니게 된다.
            //4 - 1)
            player?.play()
            //오류에 대한 변수 생성
        } catch let error {
            print("재생하는데 오류가 발생했습니다. \(error.localizedDescription)")
        }
        
    }
    
}

//MARK: BODY
struct SoundsView: View {
    
    var body: some View {
        VStack(spacing: 50) {
            Button(action: {
                //8.
                    SoundSetting.instance.palysound(sound: .click)
                
            }) {
                imageViews(imageName: "cursorarrow.rays", iconColor: .yellow)
            }
            
            Button(action: {
                SoundSetting.instance.palysound(sound: .knock)
            }) {
                imageViews(imageName: "person.fill.questionmark", iconColor: Color("Peach"))
            }
        }
    }
}

//MARK: IMAGE VIEWS
struct imageViews: View {
    var imageName: String
    var iconColor: Color
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(iconColor)
    }
}

//MARK: PREVIEWS
struct SoundsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundsView()
    }
}
