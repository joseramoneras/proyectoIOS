//
//  ClienteRest.swift
//  ProyectoIOS
//
//  Created by ramon on 14/2/17.
//  Copyright © 2017 dam. All rights reserved.
//

import Foundation

class ClienteRest{
    //let urlApi: String = "https://aplicacion-ios-jotaeme.c9users.io/ios/"
    let urlApi: String = "http://192.168.208.168:8181/ios/ios/"
    let respuesta: RestResponseReceiver
    let sesion: URLSession
    var urlPeticion: URLRequest
    
    
    
    init?(target: String, responseObject: RestResponseReceiver, _ method: String = "GET", _ data : [String:Any] = [:]) {
        guard let url = URL(string: self.urlApi + target) else {
            return nil
        }
        self.respuesta = responseObject
        self.sesion = URLSession(configuration: URLSessionConfiguration.default)
        self.urlPeticion = URLRequest(url: url)
        self.urlPeticion.httpMethod = method
        
        print(url)
        
        if method != "GET" && data.count > 0 {
            guard let json = RestJsonUtil.dictToJson(data: data) else {
                return nil
            }
            self.urlPeticion.addValue("application/json", forHTTPHeaderField: "Content-Type")
            self.urlPeticion.httpBody = json
        }
    }
    
    func request() -> Bool {
        let task = self.sesion.dataTask(with: self.urlPeticion, completionHandler: self.callBack)
        task.resume()
        return true
    }
    
    
    private func callBack(_ data: Data?, _ respuesta: URLResponse?, _ error: Error?) {
        DispatchQueue.main.async{
            guard error == nil else {
                self.respuesta.onErrorReceivingData(message: "error")
                return
            }
            guard let datos = data else {
                self.respuesta.onErrorReceivingData(message: "error datos")
                return
            }
            self.respuesta.onDataReceived(data: datos)
        }
    }
    
    
    
    
}
