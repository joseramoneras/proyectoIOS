//
//  Actividad.swift
//  ProyectoIOS
//
//  Created by dam on 26/1/17.
//  Copyright © 2017 dam. All rights reserved.
//
//sustituir hora de inicio y hora de fin por horas reales y no Strings
import UIKit
class Actividad {
    
    //MARK: properties
    var idActividad: Int
    var nombreActividad: String
    var fechaActividad: String
    var lugar: String
    var horaInicio: String
    var horaFin: String
    var descripcion: String
    var descripcionCorta: String
    var grupoActividad: Grupo?
    var profeActividad: Profesor?
    
    //Titulo, Fecha, Kugar, Hora inicio, Hora Fin, Foto (opcional, id profesor que la hace, id grupo)
    
    convenience init(){
        self.init(idActividad: 0, nombreActividad: "", fechaActividad: "", lugar: "", horaInicio: "", horaFin: "", descripcion: "", descripcionCorta: "", grupoActividad: Grupo.init()!, profeActividad: Profesor.init()!)
    }
    
    init(idActividad: Int, nombreActividad: String, fechaActividad: String,  lugar: String, horaInicio: String, horaFin: String, descripcion: String, descripcionCorta: String, grupoActividad: Grupo, profeActividad: Profesor) {
        // Initialize stored properties.
        self.idActividad = idActividad
        self.nombreActividad = nombreActividad
        self.fechaActividad = fechaActividad
        self.lugar = lugar
        self.horaInicio = horaInicio
        self.horaFin = horaFin
        self.descripcion = descripcion
        self.descripcionCorta = descripcionCorta
        self.grupoActividad = grupoActividad
        self.profeActividad = profeActividad
        
    }
    
    init(nombreActividad: String, fechaActividad: String,  lugar: String, horaInicio: String, horaFin: String, descripcion: String, descripcionCorta: String) {
        // Initialize stored properties.
        self.idActividad = 0
        self.nombreActividad = nombreActividad
        self.fechaActividad = fechaActividad
        self.lugar = lugar
        self.horaInicio = horaInicio
        self.horaFin = horaFin
        self.descripcion = descripcion
        self.descripcionCorta = descripcionCorta
        self.grupoActividad = nil
        self.profeActividad = nil
        
    }
    
    func cortarDescripcion(cadenaOriginal :String)-> String {
        let index = cadenaOriginal.index(cadenaOriginal.startIndex, offsetBy: 40);
        var resultado = cadenaOriginal.substring(to: index)
        resultado = resultado + "..."
        return resultado
    }
    
    init(_ diccionario: [String: Any]) {
        self.idActividad = diccionario["id"] as! Int
        self.nombreActividad = diccionario["titulo"] as! String
        self.fechaActividad = diccionario["fecha"] as! String
        self.lugar = diccionario["lugar"] as! String
        self.horaInicio = diccionario["horaInicial"] as! String
        self.horaFin = diccionario["horaFinal"] as! String
        self.descripcion = diccionario["descripcion"] as! String
        self.descripcionCorta = diccionario["descripcionCorta"] as! String
        self.grupoActividad = Grupo.init(nombre: diccionario["nombreGrupo"] as! String, id: diccionario["idGrupo"] as! Int)!
        self.profeActividad = Profesor.init(idProfesor:  diccionario["idProfesor"] as! Int, nombreProfesor: diccionario["nombreProfesor"] as! String, departamentoProfesor: diccionario["departamentoProfesor"] as! String)
        }
}
