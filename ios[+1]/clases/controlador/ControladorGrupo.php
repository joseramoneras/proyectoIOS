<?php
require_once('../clases/AutoCarga.php');

class ControladorGrupo {
    
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
            $grupos = $modelo->buscarGrupos();
            //$profe = $profesores->getArray(); 
            $json = json_encode($grupos); 
            return  $json; 
        }elseif($modelo->buscarGrupo($id)){
            $grupo = $modelo->buscarGrupo($id);
            $g = $grupo->getArray(); 
            $json = json_encode($g); 
            return  $json;   
        }
        else{
            return '{"response":"Grupo no encontrado."}';
        }
        return $id;
    }
    
    function post(){
        $g = new Grupo();
        $g->setNombre($this->objeto->nombre);
        $modelo = new Modelo();
        $modelo->insertarGrupo($g);
        return $g->getIdGrupo();
    }
} 