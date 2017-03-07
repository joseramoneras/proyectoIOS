<?php
require_once('../clases/AutoCarga.php');

class ControladorActividad {
    
    private $objeto;
    private $rest;
    private $get;
    
    function __construct($objeto, $rest, $get){
        $this->objeto = $objeto;
        $this->rest = $rest;
        $this->get = $get;
    }
    
    function get(){
        $parametro = $this->rest[1];
        
        if(is_numeric($parametro) || empty($parametro)){
            return $this->buscarActividad($parametro);
        }elseif($parametro === "profesor"){
            return $this->buscarActividadDeProfesores($parametro);
        }elseif($parametro === "fecha"){
            return $this->buscarActividadPorFecha($parametro);
        }
        else{
            return '{"response":"Datos no encontrados."}';
        }
    }
    
    function post(){
        //se le pasa la fecha m-d-Y  y lo pasamos a y-m-d
        $descripcionCorta = $this->objeto->descripcion;
        $descripcionCorta = substr($descripcionCorta, 0, 30);
        
        $a = new Actividad();    
        $a->setDescripcion($this->objeto->descripcion);
        $a->setDescripcionCorta($descripcionCorta." ...");
        $a->setTitulo($this->objeto->titulo);
        $a->setFecha(date_create($this->objeto->fecha));
        $a->setLugar($this->objeto->lugar);
        $a->setHoraInicial(date_create($this->objeto->horaInicial));
        $a->setHoraFinal(date_create($this->objeto->horaFinal));
        $a->setFotoRepresentativaExcursion($this->objeto->fotoRepresentativaExcursion);
        
        //---------------CLAVES FORANEAS----------------------
        $modelo = new Modelo();
        $profesor = $modelo->buscarProfesor($this->objeto->idProfesor);
        $a->setIdProfesor($profesor);
        $grupo = $modelo->buscarGrupo($this->objeto->idGrupo);
        $a->setIdGrupo($grupo);
        
        $respuesta = $modelo->insertarActividad($a);
        
        $json = $a->getArray($respuesta);
        $json = json_encode($json);
        return $json;
        //{"id":"46", "descripcion" :"hola1", "titulo":"tituloUpdate", "fecha":"8/2/2017", "lugar":"IES", "horaInicial":"10:01", "horaFinal":"10:04", "fotoRepresentativaExcursion":"fotoPrueba", "idProfesor" :"20","idGrupo":"2" }
    }
    
    function delete(){
        $id = $this->objeto->id;
        echo "controlador: ".$id;
        $modelo = new Modelo();
        $borrada = $modelo->deleteActividad($id);
        return $borrada;
    }
    
    function put(){
        $modelo = new Modelo();
        $parametro = $this->rest[1];
        
        if($this->objeto->id){
            $actividad = $modelo->buscarActividad($this->objeto->id); 
        }/*elseif($parametro){
            $actividad = $modelo->buscarActividad($parametro);
        }*/else{
            return '{"response":"No se ha pasado id para modificar."}';
        }
        
        if($actividad){
            $descripcionCorta = $this->objeto->descripcion;
            $descripcionCorta = substr($descripcionCorta, 0, 60);
           
            $actividad->setDescripcion($this->objeto->descripcion);
            $actividad->setDescripcionCorta($descripcionCorta." ...");
            $actividad->setTitulo($this->objeto->titulo);
            $actividad->setFecha(date_create($this->objeto->fecha));
            $actividad->setLugar($this->objeto->lugar);
            $actividad->setHoraInicial(date_create($this->objeto->horaInicial));
            $actividad->setHoraFinal(date_create($this->objeto->horaFinal));
            $actividad->setFotoRepresentativaExcursion($this->objeto->fotoRepresentativaExcursion);
            
            $profesor = $modelo->buscarProfesor($this->objeto->idProfesor);
            $actividad->setIdProfesor($profesor);
            $grupo = $modelo->buscarGrupo($this->objeto->idGrupo);
            $actividad->setIdGrupo($grupo);
            
            $respuesta = $modelo->actualizarActividad($actividad);
            /*if($respuesta){
                $json = $actividad->getArray($respuesta);
                $json = json_encode($json);
                return $json;
            }else{
                return '{"response":"No se ha podido modificar."}';
            }*/
            
            return $respuesta;
            
        }else{
            return '{"response": "No existe esa actividad."}';
        }
    }
    
    function buscarActividad($parametro){
        $modelo = new Modelo();
        if(empty($parametro)){
            $actividades = $modelo->buscarActividades();
            //var_dump($actividades);
            $json = json_encode($actividades); 
            //var_dump($json);
            return  $json; 
        }
        elseif($modelo->buscarActividad($parametro)){
            $actividad = $modelo->buscarActividad($parametro);
            $a = $actividad->getArray(); 
            $json = json_encode($a); 
            return  $json;   
        }
        else{
            return '{"response":"Actividad no encontrada."}';
        }
    }
    
    function buscarActividadDeProfesores($parametro){
        $modelo = new Modelo();
        $id = $this->rest[2];
        if(!empty($id)){
            $actividadesProfesor = $modelo->buscarActividadIdProfesor($id);
            if($actividadesProfesor){
                $json = json_encode($actividadesProfesor); 
                return  $json; 
            }else{
                return '{"response":"Este profesor no tiene actividades."}';
            }
        }else{
            return '{"response":"No se ha introducido ID del profesor."}';
        }
    }
    function buscarActividadPorFecha($parametro){
        $modelo = new Modelo();
        $fecha = $this->rest[2];
        if(!empty($fecha)){
            $actividadProFecha = $modelo->buscarActividadPorFecha($fecha);
            if($actividadProFecha){
                $json = json_encode($actividadProFecha); 
                return $json; 
            }else{
                return '{"response":"No hay actividades para esa fecha."}';
            }
        }else{
            return '{"response":"No se ha introducido fecha de busqueda."}';
        }
    }
    
} 