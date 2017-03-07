//
//  Grupo.swift
//  ProyectoIOS
//
//  Created by dam on 14/2/17.
//  Copyright © 2017 dam. All rights reserved.
//

import Foundation
class Grupo{
    
    //MARK: Properties
    var nombreGrupo : String
    var idGrupo : Int
    
    //MARK: Method
    convenience init?(){
        self.init(nombre: "", id: 0)
    }
    init?(nombre: String, id: Int){
        self.nombreGrupo = nombre
        self.idGrupo = id
    }
    init(_ diccionario: [String: Any]) {
        
        self.nombreGrupo = diccionario["nombreGrupo"] as! String
        self.idGrupo = diccionario["id"] as! Int
    }
}
