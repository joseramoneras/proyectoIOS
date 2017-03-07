//
//  ActividadViewController.swift
//  ProyectoIOS
//
//  Created by dam on 26/1/17.
//  Copyright © 2017 dam. All rights reserved.
//


//tenemos que definir una manera de mostrar el nombre del profesor que lleva a cabo la actividad, y las fechas tienen que funcionar con datepicker
//ibas por apañartelas para que el otro datapicker también funcione, se te ha ocurrido hacer dos clases delegate y datasource, una para cada uno, pero no lo has probado


import UIKit
import os.log

class ActividadViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource,UIPickerViewDelegate, RestResponseReceiver {

    //MARK: properties
    var profesores = [Profesor]()
    var grupos = [Grupo]()
    var listadoProfes = [String]()
    var listadoGrupos = [String]()
    var actividad : Actividad?
    var controller:ActividadTableViewController?
    var nueva: Bool = false
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nombreActividad: UITextField!
    @IBOutlet weak var fechaActividad: UITextField!
    @IBOutlet weak var nombreGrupo: UITextField!
    @IBOutlet weak var comienzoActividad: UITextField!
    @IBOutlet weak var finActividad: UITextField!
    @IBOutlet weak var descripcionActividad: UITextView!
    @IBOutlet weak var nombreProfesor: UITextField!
    @IBOutlet weak var datePickerFecha: UIDatePicker!
    @IBOutlet weak var datePickerComienzo: UIDatePicker!
    @IBOutlet weak var datePickerFinal: UIDatePicker!
    @IBOutlet weak var listaProfes: UIPickerView!
    @IBOutlet weak var listaGrupos: UIPickerView!
    @IBOutlet weak var lugar: UITextField!
    
    
        //MARK: metodos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        llamadaRestProfesores()
        llamadaRestGrupos()
        let fecha = actividad?.fechaActividad
        let horaFin = actividad?.horaFin
        let horaInicio = actividad?.horaInicio
        listaProfes.dataSource = self
        listaProfes.delegate =  self
        listaGrupos.delegate = self
        listaGrupos.dataSource = self
        finActividad.isEnabled = false
        comienzoActividad.isEnabled = false
        fechaActividad.isEnabled = false
        nombreProfesor.isEnabled = false
        nombreGrupo.isEnabled = false
        
        // Preparamos las vistas por si llega una actividad nueva
        if let actividad = actividad {
            navigationItem.title = actividad.nombreActividad
            nombreActividad.text = actividad.nombreActividad
            datePickerFecha.date = convertirFechaString(fecha: actividad.fechaActividad)
            fechaActividad.text = actividad.fechaActividad
            nombreProfesor.text = actividad.profeActividad?.nombreProfesor
            nombreGrupo.text = actividad.grupoActividad?.nombreGrupo
            comienzoActividad.text = horaInicio
            datePickerComienzo.date = convertirHoraString(fecha: actividad.horaInicio)
            descripcionActividad.text = actividad.descripcion
            datePickerFinal.date = convertirHoraString(fecha: actividad.horaFin)
            finActividad.text = horaFin
            lugar.text = actividad.lugar
        }else{
            saveButton.isEnabled = false
            datePickerFecha.date = Date()
            datePickerComienzo.date = Date()
            datePickerFinal.date = Date()
            fechaActividad.text = convertirFecha(fecha: Date())
            comienzoActividad.text = convertirHora(fecha: Date())
            finActividad.text = convertirHora(fecha: Date())
            actividad = Actividad.init(nombreActividad: "", fechaActividad: "", lugar: "", horaInicio: "", horaFin: "", descripcion: "", descripcionCorta:"")
            nueva = true
            }
        
        // Enable the Save button only if the text field has a valid Meal name.
        //updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    @IBAction func escuchadorEditar(_ sender: UITextField) {
        updateSaveButtonState()
        navigationItem.title = nombreActividad.text
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Navegación
    
    @IBAction func Save(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    
    
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print("has pulsado el boton guardar")
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let nLugar = lugar.text!
        let nNombreActividad = nombreActividad.text!
        let nDescripcionActividad = descripcionActividad.text!
        var nDescripcionCortaActividad = ""
        let nFechaActividad = convertirFecha(fecha: datePickerFecha.date)
        let nProfesor = self.actividad?.profeActividad
        let nGrupo = self.actividad?.grupoActividad
        let nComienzoActividad = convertirHora(fecha: datePickerComienzo.date)
        let nFinActividad = convertirHora(fecha: datePickerFinal.date)
        if(nDescripcionActividad.characters.count>9){
          let index = nDescripcionActividad.index(nDescripcionActividad.startIndex, offsetBy: 10)
            nDescripcionCortaActividad = nDescripcionActividad.substring(to: index)
        }else{
            nDescripcionCortaActividad = nDescripcionActividad
        }
        var idGrupo = nGrupo?.idGrupo
        var idProfe = nProfesor?.idProfesor
        
        
        if(actividad?.idActividad != 0){
            let diccionario = ["id": actividad?.idActividad ?? 0, "titulo": nNombreActividad, "fecha": nFechaActividad, "lugar": lugar.text ?? "Lugar no especificado"
                , "horaInicial" : nComienzoActividad, "horaFinal" : nFinActividad, "descripcion" : nDescripcionActividad, "idGrupo" : idGrupo ?? 0, "idProfesor" : idProfe ?? 0] as [String : Any]
            llamadaRestActualizar(diccionario : diccionario)
        } else {
            let diccionario = ["titulo": nNombreActividad, "fecha": nFechaActividad, "lugar": lugar.text ?? "Lugar no especificado"
            , "horaInicial" : nComienzoActividad, "horaFinal" : nFinActividad, "descripcion" : nDescripcionActividad, "idGrupo" : idGrupo ?? 0, "idProfesor" : idProfe ?? 0] as [String : Any]
            llamadaRestGuardar(diccionario : diccionario)
        }
        
        
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let textTitulo =  nombreActividad.text ?? ""
        saveButton.isEnabled = !(textTitulo.isEmpty)
    }
    
    func convertirFecha(fecha:Date)->String{
        //MARK: Propiedades funcion convertir
        let dateFormatter = DateFormatter()
        var cadena: String
        
        //Definimos el formato del dateformatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //Convertimos la fecha a string segun nuestro dateFormatter y la almacenamos en la cadena
        cadena = dateFormatter.string(from: fecha)
        return cadena
    }
    func convertirHora(fecha:Date)->String{
    //MARK: Propiedades funcion convertir
    let dateFormatter = DateFormatter()
    var cadena: String
    
    //Definimos el formato del dateformatter
    dateFormatter.locale = Locale(identifier: "es_ES")
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    
    //Convertimos la fecha a string segun nuestro dateFormatter y la almacenamos en la cadena
    cadena = dateFormatter.string(from: fecha)
    return cadena
    }
    
    func convertirFechaString(fecha: String )->Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-dd"
        dateFormatter.locale = Locale.init(identifier: "ES_es")
        let dateObj = dateFormatter.date(from: fecha)
        return dateObj!;
    }
    func convertirHoraString(fecha: String )->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm"
        dateFormatter.locale = Locale.init(identifier: "ES_es")
        let dateObj = dateFormatter.date(from: fecha)
        return dateObj!;
    }
    
    
    
    
    
    //MARK: metodos rest
    func llamadaRestActualizar(diccionario : [String : Any]){
        guard let cliente = ClienteRest(target: "actividad", responseObject: controller!, "PUT", diccionario ) else {
            return
        }
        cliente.request()
        
    }
    
    func llamadaRestGuardar(diccionario : [String : Any]){
        guard let cliente = ClienteRest(target: "actividad", responseObject: controller!, "POST", diccionario ) else {
            return
        }
        cliente.request()

    }
    
    func llamadaRestProfesores() {
        guard let cliente = ClienteRest(target: "profesor", responseObject: self) else {
            return
        }
        (cliente.request())
    }
    
    func llamadaRestGrupos() {
        
        guard let cliente = ClienteRest(target: "grupo", responseObject: self) else {
            return
        }
        cliente.request()
    }
    
    func onDataReceived(data: Data) {
        guard let diccionario = RestJsonUtil.jsonToDict(data: data) else {
            return
        }
        let almacen = diccionario[1]
        let comprobar = almacen["nombreProfesor"]
        if(comprobar != nil){
            self.profesores = RestJsonUtil.getArrayProfesorFromJson(diccionario: diccionario)
            if(nueva){
                actividad?.profeActividad = profesores[0]
                nombreProfesor.text = profesores[0].nombreProfesor
            }
            iniciarProfes(profesores: profesores)
            DispatchQueue.main.async {
                self.listaProfes.reloadAllComponents()
            }

        }else {
            self.grupos = RestJsonUtil.getArrayGruposFromJson(diccionario: diccionario)
            if(nueva){
                actividad?.grupoActividad = grupos[0]
                nombreGrupo.text = grupos[0].nombreGrupo
            }
            iniciarGrupos(grupos: grupos)
            DispatchQueue.main.async {
                self.listaGrupos.reloadAllComponents()
            }
        }
        
    }
    
    func onErrorReceivingData(message: String) {
        print(message)
    }
    
    func iniciarProfes(profesores: [Profesor]){
        for profesor in profesores{
            listadoProfes.append(profesor.nombreProfesor)
        }
        
    }
    func iniciarGrupos(grupos: [Grupo]){
        for grupo in grupos{
            listadoGrupos.append(grupo.nombreGrupo)
        }
        
    }
    

    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            if pickerView == listaProfes{
                return 1
                
            } else if pickerView == listaGrupos{
                return 1
        }
        return 1
    }
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == listaProfes{
                return listadoProfes.count
                
            } else if pickerView == listaGrupos{
                return listadoGrupos.count
            }
        return listadoProfes.count
    }
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        if (sender == datePickerFecha){
            fechaActividad.text = convertirFecha(fecha: datePickerFecha.date)
        }else if(sender == datePickerFinal){
            finActividad.text = convertirHora(fecha: datePickerFinal.date)
        }else if(sender == datePickerComienzo){
            comienzoActividad.text = convertirHora(fecha: datePickerComienzo.date)
        }
    }
    
    
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == listaProfes{
            return listadoProfes[row]
        } else if pickerView == listaGrupos{
            return listadoGrupos[row]
        }
        return listadoProfes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == listaProfes{
            nombreProfesor.text = listadoProfes[row]
            actividad?.profeActividad = profesores[row]
        } else if pickerView == listaGrupos{
            nombreGrupo.text = listadoGrupos[row]
            actividad?.grupoActividad = grupos[row]
        }
    }
}

