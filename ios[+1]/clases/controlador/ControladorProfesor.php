<?php
require_once('../clases/AutoCarga.php');

class ControladorProfesor {
    
    private $objeto;
    private $rest;
    private $get;
    
    function __construct($objeto, $rest, $get){
        $this->objeto = $objeto;
        $this->rest = $rest;
        $this->get = $get;
    }
    
    function get(){
        $id = $this->rest[1];
       
        $modelo = new Modelo();
        if(empty($id)){
            $profesores = $modelo->buscarProfesores();
            //$profe = $profesores->getArray(); 
            $json = json_encode($profesores); 
            return  $json; 
        }
        elseif($modelo->buscarProfesor($id)){
            $profesor = $modelo->buscarProfesor($id);
            $profe = $profesor->getArray(); 
            $json = json_encode($profe); 
            return  $json;   
        }
        else{
            return '{"response":"Profesor no encontrado."}';
        }
    }
    
    function post(){
        $p = new Profesor();
        $p->setNombre($this->objeto->nombre);
        $p->setDepartamento($this->objeto->departamento);
        $modelo = new Modelo();
        $modelo->insertarProfesor($p);
        return $p->getIdProfesor();
    }
} 