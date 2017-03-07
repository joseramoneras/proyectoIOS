//
//  RestJson.swift
//  ProyectoIOS
//
//  Created by ramon on 14/2/17.
//  Copyright © 2017 dam. All rights reserved.
//

import Foundation

class RestJsonUtil{
    
    
    static func dictToJson(data: [String:Any]) -> Data? {
        guard let json = try? JSONSerialization.data(withJSONObject: data as Any,
                                                     options: []) else {
                                                        return nil
        }
        return json
    }
    
    
    static func jsonToDict(data: Data) -> [[String: Any]]? {
        guard let diccionario = try? JSONSerialization.jsonObject(with: data, options: [])
            as? [[String: Any]] else {
                return nil
        }
        return diccionario
    }
    
    
    static func getArrayActividadFromJson(diccionario: [[String : Any]]) -> [Actividad] {
        var actividades: [Actividad] = []
        /*guard let diccionarioActividades = diccionario["actividades"] as?[[String: Any]] else {
         return actividades
         }*/
        for diccionarioActividad in diccionario {
            actividades.append(Actividad(diccionarioActividad))
        }
        return actividades
    }
    
    static func getArrayProfesorFromJson(diccionario: [[String : Any]]) -> [Profesor] {
        var profesores: [Profesor] = []
        /*guard let diccionarioActividades = diccionario["actividades"] as?[[String: Any]] else {
         return actividades
         }*/
        for diccionarioProfesor in diccionario {
            profesores.append(Profesor(diccionarioProfesor))
        }
        return profesores
    }
    
    static func getArrayGruposFromJson(diccionario: [[String : Any]]) -> [Grupo] {
        var grupos: [Grupo] = []
        /*guard let diccionarioActividades = diccionario["actividades"] as?[[String: Any]] else {
         return actividades
         }*/
        for diccionarioGrupos in diccionario {
            grupos.append(Grupo(diccionarioGrupos))
        }
        return grupos
    }


}

