//
//  LocationManager.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/12.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager : NSObject{
    
    static var shared = LocationManager()
    
    lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    typealias AuthChangedBlock = EmptyCompleteBlock
    
    typealias CurrentLocationBlock = ReturnValueBlock<CLLocation>
    
    var authChangedBlock : AuthChangedBlock?
    
    var currentLocationBlock : CurrentLocationBlock?
    
    /// 需要在info.plist文件中添加
    ///
    /*  <!-- 在使用期间访问位置 -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>App需要您的同意,才能在使用期间访问位置</string>
     */
    ///
    static func currentLocation(_ locationBlock:@escaping CurrentLocationBlock){
        
        self.shared.currentLocationBlock = locationBlock
        
        self.requestAuthorization {
            
            if CLLocationManager.locationServicesEnabled(){
                //设置定位模式
                shared.manager.desiredAccuracy = kCLLocationAccuracyBest
                // 发起获取位置
                shared.manager.requestLocation()
            }
            else{
                Toast(LocalizationString.Authorization.locationTips)
            }
        }
    }
    
    /// 获取位置授权
    /// - Parameter completeBlock: ~
    fileprivate static func requestAuthorization(_ completeBlock:@escaping EmptyCompleteBlock){
        
        var locationStatus : CLAuthorizationStatus = .notDetermined
        if #available(iOS 14.0, *) {
            locationStatus = shared.manager.authorizationStatus
        } else {
            locationStatus = CLLocationManager.authorizationStatus()
        }
        if locationStatus == .notDetermined{
            shared.manager.requestWhenInUseAuthorization()
            shared.authChangedBlock = completeBlock
        }
        else{
            completeBlock()
        }
    }
}

extension LocationManager : CLLocationManagerDelegate{
    
    /// 14.0以前,监听权限变动
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard let authChangedBlock = self.authChangedBlock else {
            return
        }
        authChangedBlock()
    }
    /// 14.0以后,监听权限变动
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        guard let authChangedBlock = self.authChangedBlock else {
            return
        }
        authChangedBlock()
    }
    ///返回定位的位置
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else {
            return
        }
        if let currentBlock = self.currentLocationBlock , let current = locations.last {
            currentBlock(current)
        }
    }
    ///定位错误
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let baseErr = LocalizationString.Authorization.locationFail
        Toast(baseErr + ",\(error)")
    }
}

extension CLLocation{
    
    /// 地址返编码
    func reverseGeocode(_ successedBlock:@escaping ReturnValueBlock<CLPlacemark>){
        
        let handler :(Array<CLPlacemark>?, Error?) -> () = { placeMarks , error  in
         
            guard error == nil else{
                debugPrint(error!.localizedDescription)
                return
            }
            guard let place = placeMarks?.first else{
                debugPrint("NO Place")
                return
            }
            successedBlock(place)
        }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(self, completionHandler: handler)
    }
}
