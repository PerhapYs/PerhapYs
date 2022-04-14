//
//  AuthorizationManager.swift
//  YuanJuBian
//
//  Created by apple on 2022/3/4.
//

import UIKit
import AVFoundation
import AppTrackingTransparency
import CoreLocation
import Photos

/*
 <!-- 麦克风 -->
 <key>NSMicrophoneUsageDescription</key>
 <string>App需要您的同意,才能访问麦克风</string>

 <!-- 相册 -->
 <key>NSPhotoLibraryUsageDescription</key>
 <string>App需要您的同意,才能访问相册</string>

 <!-- 相机 -->
 <key>NSCameraUsageDescription</key>
 <string>App需要您的同意,才能访问相机</string>

 <!-- 通讯录 -->
 <key>NSContactsUsageDescription</key>
 <string>App需要您的同意,才能访问通讯录</string>

 <!-- 蓝牙 -->
 <key>NSBluetoothPeripheralUsageDescription</key>
 <string>App需要您的同意,才能使用蓝牙</string>

 <!-- 语音转文字 -->
 <key>NSSpeechRecognitionUsageDescription</key>
 <string>App需要您的同意,才能使用语音识别</string>

 <!-- 日历 -->
 <key>NSCalendarsUsageDescription</key>
 <string>App需要您的同意,才能访问日历</string>

 <!-- 位置 -->
 <key>NSLocationUsageDescription</key>
 <string>App需要您的同意,才能访问位置</string>

 <!-- 在使用期间访问位置 -->
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>App需要您的同意,才能在使用期间访问位置</string>

 <!-- 始终访问位置 -->
 <key>NSLocationAlwaysUsageDescription</key>
 <string>App需要您的同意,才能始终访问位置</string>

 <!-- 媒体资料库 -->
 <key>NSAppleMediaLibraryUsageDescription</key>
 <string>App需要您的同意,才能访问媒体资料库</string>

 <!-- 音乐权限 -->
 <key>NSAppleMusicUsageDescription</key>
 <string>App需要您的同意,才能访问音乐</string>

 <!-- 提醒事项 -->
 <key>NSRemindersUsageDescription</key>
 <string>App需要您的同意,才能访问提醒事项</string>

 <!-- 运动与健身 -->
 <key>NSMotionUsageDescription</key>
 <string>App需要您的同意,才能访问运动与健身</string>

 <!-- 健康更新 -->
 <key>NSHealthUpdateUsageDescription</key>
 <string>App需要您的同意,才能访问健康更新 </string>

 <!-- 健康分享 -->
 <key>NSHealthShareUsageDescription</key>
 <string>App需要您的同意,才能访问健康分享</string>

 <!-- Siri使用 -->
 <key>NSSiriUsageDescription</key>
 <string>App需要您的同意,才能使用Siri</string>

 <!-- 电视供应商 -->
 <key>NSTVProviderUsageDescription</key>
 <string>App需要您的同意,才能使用电视供应商</string>

 <!-- 视频用户账号使用 -->
 <key>NSVideoSubscriberAccountUsageDescription</key>
 <string>App需要您的同意,才能访问视频用户账号使用权限</string>
 
 */

class AuthorizationManager: NSObject {
    
    static let share = AuthorizationManager()
    
    let clManager = CLLocationManager()
}
extension AuthorizationManager{
    
    class func openSetting(){
        
        if #available(iOS 15.4, *) {
            guard let url = URL.init(string: UIApplicationOpenNotificationSettingsURLString) else{
                return
            }
            UIApplication.shared.open(url)
        } else {
            // Fallback on earlier versions
            
            guard let url = URL.init(string: UIApplication.openSettingsURLString) else {
                return
            }
            UIApplication.shared.open(url)
        }
    }
}
extension AuthorizationManager{
    
    /// 判断应用是否有使用相机的权限
    /// - Returns: 是否可用
    class func isCaptureAllowed() -> Bool{
        
        let mediaType = AVMediaType.video
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        if authStatus == .restricted || authStatus == .denied{
            return false
        }
        return true
    }
    
    /// 判断相册权限
    /// - Returns: ~
    class func isPhotoLibraryAllowed() -> Bool{
        
        var authStatus = PHAuthorizationStatus.notDetermined
        if #available(iOS 14, *) {
            authStatus =  PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            authStatus = PHPhotoLibrary.authorizationStatus()
        }
        if authStatus == .authorized{
            return true
        }
        return false
    }
    /// 判断应用定位权限
    /// - Returns: ~
    class func isLocationAllowed() -> Bool{
        
        var locationStatus : CLAuthorizationStatus = .notDetermined
        if #available(iOS 14.0, *) {
            locationStatus = share.clManager.authorizationStatus
        } else {
            locationStatus = CLLocationManager.authorizationStatus()
        }
        if locationStatus == .authorizedAlways || locationStatus == .authorizedWhenInUse{
            return true
        }
        return false
    }
}

extension AuthorizationManager{
    
//    /// 获取相册权限
//    /// - Parameter complete: ~
//    class func requestPhotoLibraryAuthorization(_ complete:((PHAuthorizationStatus)->())? = nil){
//        if #available(iOS 14.0, *) {
//
//            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
//                if let complete = complete{
//                    DispatchQueue.main.async {
//                        complete(status)
//                    }
//                }
//            }
//        }
//        else{
//            PHPhotoLibrary.requestAuthorization { status in
//                if let complete = complete{
//                    DispatchQueue.main.async {
//                        complete(status)
//                    }
//                }
//            }
//        }
//
//    }
//    /// 获取广告位授权
//    class func requestIDFAAuthorization(_ complete:((ATTrackingManager.AuthorizationStatus)->())? = nil){
//        guard #available(iOS 14, *) else {
//            return
//        }
//        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined{
//            ATTrackingManager.requestTrackingAuthorization { status in
//                if let complete = complete {
//                    DispatchQueue.main.async {
//                        complete(status)
//                    }
//                }
//            }
//        }
//    }
//
//    /// 获取定位授权
//    class func requestLocationAuthorization(){
//
//        var locationStatus : CLAuthorizationStatus = .notDetermined
//        if #available(iOS 14.0, *) {
//            locationStatus = share.clManager.authorizationStatus
//        } else {
//            locationStatus = CLLocationManager.authorizationStatus()
//        }
//        if locationStatus == .notDetermined{
//            share.clManager.requestWhenInUseAuthorization()
//        }
//    }
//
//    /// 获取相机，麦克风等授权
//    class func requestCameraAuthorization(for mediaType: AVMediaType = .video){
//
//        AVCaptureDevice.requestAccess(for: mediaType) { isSuccessed in
//
//        }
//    }
}
