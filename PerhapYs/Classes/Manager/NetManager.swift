//
//  NetManager.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2021/12/16.
//

import Foundation

#if canImport(Alamofire) && canImport(HandyJSON)
import Alamofire
import HandyJSON

enum ResponseError  :   Int {
    
    case    unkown      =    0  //未知
    case    success     =   200 //成功
    case    expaired    =   300 //登录失效
    case    normal      =   400 //通用错误
}

struct ResponseDefault : HandyJSON {}

struct ResponseData : HandyJSON{
    
    var code    :   Int?
    var message     :   String?
    var result    :   Any?
}

struct ResponseModel<T:HandyJSON>{
    
    var errorCode       :   ResponseError = .unkown
    var errorMessage    :   String = "未知错误"
    var model           :   T?
    var models          :   [T?]?
    var resultData      :   Any?
}

class NetManager {
    
    /// 单例
    static let share : NetManager = {
     
        let manager = NetManager()
        manager.listenNetworkStatus()
        return manager
    }()
    
    /// 接口地址
    let RequestUrlHost : String = "http://8.218.28.119/"
    
    /// 参数编码方式
    let YJBParameterEncoder : ParameterEncoder = JSONParameterEncoder.default
    
    //下方属性为监听网络状态使用
    let semaphore = DispatchSemaphore.init(value: 1)
    
    var networkSuccessedBlock : EmptyCompleteBlock?
    
    var isNetworkReachable  = NetworkReachabilityManager.default != nil ? NetworkReachabilityManager.default!.isReachable : false
}
extension NetManager{
    
    //检查当前网络是否可用
    class func networkReachable(_ networkReachableBlock:@escaping EmptyCompleteBlock){
        
        guard !share.isNetworkReachable else {//网络当前可用，直接触发请求
            return networkReachableBlock()
        }
        //开启异步，等待网络变更.
        DispatchQueue.global().async {
            share.semaphore.wait()  //如果有其他请求进入，进入无限期等待
            if share.isNetworkReachable{
                share.semaphore.signal()  //等待完成后，如果网络状态变更为可用，则返回,重置信号量
                return networkReachableBlock()
            }
            share.networkSuccessedBlock = {  // 网络变更为可用才有的回调
                share.semaphore.signal() // 接收到网络变更为可用，重置信号量
            }
            share.semaphore.wait() //无限期等待网络变更为可用后，回调继续执行请求
            networkReachableBlock()
            share.semaphore.signal() // 重置信号量
        }
    }
    
    /// 监听网络状态
    func listenNetworkStatus(){
        
        guard let _ = NetworkReachabilityManager.default else {
            return
        }
        NetworkReachabilityManager.default!.startListening(onQueue: DispatchQueue.main, onUpdatePerforming: { status in
            switch status {
            case .unknown:
                fallthrough
            case .notReachable:
                self.isNetworkReachable = false
            case .reachable(.ethernetOrWiFi):
                fallthrough
            case .reachable(.cellular):
                self.isNetworkReachable = true
                if let _ = self.networkSuccessedBlock{
                    self.networkSuccessedBlock!()
                }
            }
        })
    }
}
extension NetManager{
    
    class func InitDataRequest<Parameters: Encodable>(url:String,
                               method:HTTPMethod = .post,
                               parameters:Parameters? = nil
    ) -> DataRequest{
        
        let headers : HTTPHeaders = HTTPHeaders()
        let encoder : ParameterEncoder = NetManager.share.YJBParameterEncoder
        let requestUrl = url.jointHost()
        
        let request : DataRequest = AF.request(requestUrl, method: method, parameters: parameters, encoder: encoder, headers: headers, interceptor: nil, requestModifier: nil)
        return request
    }
}

typealias ResponseBlock<T:HandyJSON> = (_ responseModel:ResponseModel<T>) -> ()

extension NetManager{
    ///可无参数，无模型数据返回
    class func request(url:String,
                       method:HTTPMethod = .post,
                       parametersDic:[String:String]? = [:],
                       resultBlock:ResponseBlock<ResponseDefault>?){
        self.request(url: url, method: method, parametersDic: parametersDic, modelType: ResponseDefault.self, resultBlock: resultBlock)
    }
    /// 可无参数
    class func request<T:HandyJSON>(url:String,
                       method:HTTPMethod = .post,
                       parametersDic:[String:String]? = [:],
                       modelType:T.Type,
                       resultBlock:ResponseBlock<T>?){
        self.request(url: url, method: method, parameters: parametersDic, modelType: modelType, resultBlock: resultBlock)
    }
    /// 无模型数据返回
    class func request<Parameters: Encodable>(url:String,
                                              method:HTTPMethod = .post,
                                              parameters:Parameters,
                                              resultBlock:ResponseBlock<ResponseDefault>?){
        self.request(url: url, method: method, parameters: parameters, modelType: ResponseDefault.self, resultBlock: resultBlock)
    }
    
    /// 数据模型返回
    class func request<T:HandyJSON,Parameters: Encodable>(url:String,
                                                          method:HTTPMethod = .post,
                                                          parameters:Parameters,
                                                          modelType:T.Type,
                                                          resultBlock:ResponseBlock<T>?)
    {
        let sendParam = NetManagerHelper.jointBaseParam(param: parameters)
        self.networkReachable {
            NetManager.InitDataRequest(url: url, method: method, parameters: sendParam)
                .responseString { string in
                    
                    if let error = string.error{
                        print(error.errorDescription as Any)
                    }
                    self.response(modelType, string.value,resultBlock)
                }
        }
    }
    fileprivate class func response<T:HandyJSON>
    (
        _ modelType:T.Type,
        _ responseData:String?,
        _ resultBlock:ResponseBlock<T>?
    ){
        guard let resultBlock = resultBlock else {
            return
        }
        var responseModel = ResponseModel<T>()
        let baseModel = ResponseData.deserialize(from: responseData)
        
        guard let baseModel = baseModel else {
            return resultBlock(responseModel)
        }
        
        let errorCode = ResponseError(rawValue: baseModel.code ?? 0) ?? .unkown
        responseModel.errorCode = errorCode
        
        if let _ = baseModel.message{
            responseModel.errorMessage = baseModel.message!
        }
        
        if errorCode == .expaired{ //如果登陆失效
            
            UserInfoManager.expaired(responseModel.errorMessage)
        }
        
        responseModel.resultData = baseModel.result
    
        // 当被转模型数据不存在,停止转模型.
        if let data = baseModel.result , modelType != ResponseDefault.self{
            
            if let dataArray = data as? [Any]{          // 解析数组
                
                responseModel.models = [T].deserialize(from: dataArray)
            }
            else if let data = data as? [String : Any]{     //解析字典
                
                responseModel.model = T.deserialize(from: data)
            }
        }
        
        return resultBlock(responseModel)
    }
}
extension NetManager{
    
    /// 上传图片
    /// - Parameters:
    ///   - url: 链接
    ///   - parameters: 参数
    ///   - imageData: 图片数据
    ///   - resultBlock: ～
    class func request<T:HandyJSON>(url:String,
                       parameters:[String : String],
                       imageData:Data,
                       modelType:T.Type,
                       resultBlock:ResponseBlock<T>?){
        
        let headers : HTTPHeaders = HTTPHeaders()
        AF.upload(multipartFormData: { fromData in
            fromData.append(imageData, withName: "file", fileName: "file.jpg", mimeType: "image/png,image/jpeg,image/jpg")
            for key in parameters.keys {
                let value = "\(parameters[key] ?? "")".data(using: .utf8)!
                fromData.append(value, withName: key)
            }
        }, to: url.jointHost() ,headers: headers)
            .responseString { string in
                
                if let error = string.error{
                    print(error.errorDescription as Any)
                }
                self.response(modelType, string.value,resultBlock)
            }
    }
    
    /// 上传多张图片
    class func request<T:HandyJSON>(url:String,
                                    parameters:[String:String],
                                    imageDatas:[Data],
                                    modelType:T.Type,
                                    resultBlock:ResponseBlock<T>?)
    {
        let headers : HTTPHeaders = HTTPHeaders()
        AF.upload(multipartFormData: { fromData in
            for key in parameters.keys {
                let value = "\(parameters[key] ?? "")".data(using: .utf8)!
                fromData.append(value, withName: key)
            }
            for (index,imageData) in imageDatas.enumerated() {
                fromData.append(imageData, withName: "file[\(index)]", fileName: "file_\(index).jpg", mimeType: "image/png,image/jpeg,image/jpg")
            }
        }, to: url.jointHost() ,headers: headers)
            .responseString { string in
                
                if let error = string.error{
                    print(error.errorDescription as Any)
                }
                self.response(modelType, string.value,resultBlock)
            }
    }
}
extension String{
    
    fileprivate func jointHost() -> String{
        
        let host = NetManager.share.RequestUrlHost
        guard !self.isEmpty else {
            return host
        }
        guard !self.contains("http") else {
            return self
        }
        return host + self
    }
}
#endif
