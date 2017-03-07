<?php

class Api {
    
    private $gestor;
    private $metodo, $json, $pRest, $pGet;
    private $respuesta;
    
    function __construct($metodo, $json, $parametrosRest, $parametrosGet) {
        $this->metodo = $metodo;
        $this->json = $json;
        $this->pRest = $parametrosRest;
        $this->pGet = $parametrosGet;
        $b = new Bootstrap();
        $this->gestor = $b->getEntityManager();
        
    }
    
    function doTask(){
        $tabla = $this->pRest[0];
        $clase = 'Controlador' . ucfirst($tabla);
        if(class_exists($clase)){
            $objeto = new $clase($this->json, $this->pRest, $this->pGet);
            $metodo = $this->metodo;
            if(method_exists($objeto, $metodo)){
                $this->respuesta = $objeto->$metodo();
            }
        }
    }
    
    function getResponse(){
        return $this->respuesta;
    }
}