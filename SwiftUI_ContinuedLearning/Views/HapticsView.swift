//
//  HapticsView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/25.
//

import SwiftUI

/*
 햅틱 효과를 적용하기 위해서는 실제 기기를 연결해야만 확인이 가능합니다.
 IOS 14.5 이상을 사용하고 있다면 XCDOE12.5 으로 업데이트해야 실행이 가능합니다.
 */

//MARK: HAPCICES CLASS
class HapticsManager {
    //1. HapticsManger의 단일 인스턴스를 만듬
    static let instance = HapticsManager()
    /// singleton ? :
    /*싱글 톤은 한 번만 생성 된 다음 사용해야하는 모든 곳에서 공유해야하는 객체입니다 */
    
    //2. notification
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    //3. impact
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}

//MARK: BODY
struct HapticsView: View {
    let generator = UINotificationFeedbackGenerator ()
    
    var body: some View {
        VStack(spacing: 20) {
            
            //4. 버튼을 생성해서 각 기본값의 기능을 직접 확인해 볼 수 있습니다.
            Text("notification").font(Font.title2.bold())
            Button("success") { HapticsManager.instance.notification(type: .success)}
            Button("error") { HapticsManager.instance.notification(type: .error)}
            Button("warning") { HapticsManager.instance.notification(type: .warning)}
            Button("success example2") {generator.notificationOccurred(.success)}
            
            //Divider을 사용할 수 도 있지만, Shape struct를 따로 만들어 아래와 같은 구분선을 만들 수 있습니다.
            Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [5])).frame(height: 1)
           
            Group {
                Text("impact").font(Font.title2.bold())
                Button("soft") { HapticsManager.instance.impact(style: .soft)}
                Button("rigid") { HapticsManager.instance.impact(style: .rigid)}
                Button("medium") { HapticsManager.instance.impact(style: .medium)}
                Button("light") { HapticsManager.instance.impact(style: .light)}
                Button("heavy") { HapticsManager.instance.impact(style: .heavy)}
                
            }
        }
        .padding()
    }
    
}

//MARK: PREVIEWS
struct HapticsView_Previews: PreviewProvider {
    static var previews: some View {
        HapticsView()
    }
}

//MARK: DASH DIVIDER
struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
