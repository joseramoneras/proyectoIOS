//
//  RestResponseReceiver.swift
//  ProyectoIOS
//
//  Created by ramon on 14/2/17.
//  Copyright © 2017 dam. All rights reserved.
//

import Foundation

protocol RestResponseReceiver {
    func onDataReceived(data: Data)
    func onErrorReceivingData(message: String)
}
