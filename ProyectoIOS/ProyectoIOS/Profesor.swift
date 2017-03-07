//
//  Profesor.swift
//  ProyectoIOS
//
//  Created by dam on 30/1/17.
//  Copyright © 2017 dam. All rights reserved.
//

import Foundation
class Profesor{
    
    //MARK: Properties
    var idProfesor: Int
    var nombreProfesor: String
    var departamentoProfesor: String
    
    //MARK: Inicialicers
    convenience init?(){
        self.init(idProfesor: 0, nombreProfesor: "", departamentoProfesor: "")
    }
    
    
    init(idProfesor: Int, nombreProfesor:String, departamentoProfesor : String){
        self.idProfesor = idProfesor
        self.nombreProfesor = nombreProfesor
        self.departamentoProfesor = departamentoProfesor
    }
    init(_ diccionario: [String: Any]) {
        self.idProfesor = diccionario["id"] as! Int
        self.nombreProfesor = diccionario["nombreProfesor"] as! String
        self.departamentoProfesor = diccionario["departamentoProfesor"] as! String
    }
}


