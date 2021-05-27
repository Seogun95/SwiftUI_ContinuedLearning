//
//  LocalNotificationView.swift
//  SwiftUI_ContinuedLearning
//
//  Created by Seogun Kim on 2021/05/26.
//

import SwiftUI
//2. UserNotifications import
import UserNotifications
//8-2. CoreLocation import
import CoreLocation

//MARK: NotificationManager
class NotificationManager {
    //1. NotificationManager의 단일 인스턴스를 만듬
    static let instance = NotificationManager()

    
    //MARK: FUNC
    //3. 알림 승인 요청 함수 생성
    func requestAuthorization() {
        
        //3-2:  let options: UNAuthorizationOptions = . 다양한 옵션 선택 가능
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        //3-1: UNUserNotificationCenter.current().requestAuthorization()
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("승인실패 : \(error)")
            } else {
                print("승인완료")
            }
        }
    }
    
    //5. 알림 승인권한 부여 후, 나올 뱃지 함수 생성
    func scheduleNotification() {
        //5-1. 변경 가능한 알림 컨텐츠 생성
        let content = UNMutableNotificationContent()
        content.title = "테스트용 알람입니다."
        content.subtitle = "SwifUI"
        content.sound = .default
        content.badge = 1
        
        // 구현해볼 목록
        /*
         1) time  (6)
         2) calender (7)
         3) location (8)
         */
        
        //6-1. time  / timeInterval: 시간 간격
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //7. calender
        //7-2. 예약시간에 대한 다양한 기능 추가 가능
        /*      var dateComponents = DateComponents()
         dateComponents.hour = 12
         dateComponents.minute = 35
         dateComponents.weekday = 5 //목요일 마다 (1: 일요일)
         //7-1. dateMatching: 원하는 시간을 정해줘야함
         let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
         */
        
        //8. location
        //8-3. 위도와 경도 (예시: 노원구)
        let coordinate = CLLocationCoordinate2D(
            latitude: 37.5666791, longitude: 126.9782914)
        //8-2. (8-3)의 coordinate 변수를 생성 후 아래에 코드 적용
        let region = CLCircularRegion(
            center: coordinate,
            //주변 반경 m
            radius: 100,
            identifier: UUID().uuidString)
        //8-1.
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        //8-4. 사용자가 해당 위치에 들어가거나 나왔을때 알람을 울림
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        //5-2. content를 호출 요청
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            //6-2. trigger 호출
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    //9. 예약된 모든 알람을 취소하는 함수
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

//MARK: BODY
struct LocalNotificationView: View {
    var body: some View {
        VStack {
            //4. body에 함수 호출
            Button("알림 권한 요청") { NotificationManager.instance.requestAuthorization()}
            //6-3
            Button("알림 확인") { NotificationManager.instance.scheduleNotification()}
            //9-1
            Button("알림 전체 취소") { NotificationManager.instance.cancelNotification()}
        }
        //앱을 실행했을때 뱃지가 사라지게 해줌
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

//MARK: FREVIEWS
struct LocalNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
    }
}
