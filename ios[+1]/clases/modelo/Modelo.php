<?php

class Modelo {
    
    private $gestor;
    
    function __construct(){
        $bs = new Bootstrap();
        $this->gestor = $bs->getEntityManager();
    }
    
    /* --------------- Funciones Profesores -------------------------*/
    
    function insertarProfesor(Profesor $objeto){
        $id = $this->gestor->persist($objeto);
        $this->gestor->flush();
        return $id ;
    }
    
    function buscarProfesor($id){
        $profe = $this->gestor->find('Profesor',$id);
        return $profe;
    }
    
    function buscarProfesores(){
         $profesores = $this->gestor->getRepository('Profesor')->findAll();
        
        $data = array();
        foreach ($profesores as $p) {
            $data[] = $p->getArray();
        }
        return $data;
    }
    
    
    /*--------------Funciones Grupos------------------------*/
    
    function buscarGrupo($id){
        $grupo = $this->gestor->find('Grupo',$id);
        return $grupo;
    }
    
    function buscarGrupos(){
         $grupos = $this->gestor->getRepository('Grupo')->findAll();
        
        $data = array();
        foreach ($grupos as $p) {
            $data[] = $p->getArray();
        }
        return $data;
    }
    
    function insertarGrupo(Grupo $objeto){
        $id = $this->gestor->persist($objeto);
        $respuesta = $this->gestor->flush();
        return $id;
    }
    
    /* -------------- Funciones Actividades ------------------*/
    
    function insertarActividad(Actividad $objeto){
        $id = $this->gestor->persist($objeto);
        $respuesta = $this->gestor->flush();
        if(!$respuesta){
            return '{"response":"La actividad se ha insertado con exito."}';
        }else{
            return '{"response":"No se ha podido insertar la actividad"}';    
        }
        
    }
     function buscarActividades(){
        $actividades = $this->gestor->getRepository('Actividad')->findAll();
        
        $data = array();
        foreach ($actividades as $p) {
            $data[] = $p->getArray();
        }
        return $data;
    }
    
    function buscarActividad($id){
        $actividad = $this->gestor->find('Actividad',$id);
        return $actividad;
    }
    
    function deleteActividad($id){
        $actividad = $this->buscarActividad($id);
        
        if($actividad){
            $this->gestor->remove($actividad);
            $this->gestor->flush();
            return '{"response":"Se ha borrado la id: '.$id.'"}';    
         }else{
             return '{"response":"No se ha borrado la id: '.$id.'"}';
         }
    }
    
    function buscarActividadIdProfesor($id){
        $actividades = $this->gestor->getRepository('Actividad')->findBy(array('idProfesor' => $id));
        $data = array();
        foreach ($actividades as $p) {
            $data[] = $p->getArray();
        }
        return $data;
    }
    
    function buscarActividadPorFecha($fecha){
        $fecha1 = $this->gestor->getRepository('Actividad')->findBy(array('fecha' => date_create($fecha)));
        
        $data = array();
        foreach ($fecha1 as $f) {
            $data[] = $f->getArray();
        }
        
        return $data;
    }
    
    function actualizarActividad($actividad){
        //$this->gestor->persist($actividad);
        $respuesta = $this->gestor->flush();
        
        if(!$respuesta){
            return '{"response":"La actividad se ha modificado con exito."}';
        }else{
            return '{"response":"No se ha podido modificar la actividad"}';    
        }
    }
}