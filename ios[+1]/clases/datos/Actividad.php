<?php

/**
 * @Entity 
 * @Table(name="actividad")
 */
class Actividad {
    
    /**
     * @Id
     * @Column(type="integer") @GeneratedValue
     */
    protected $id;
    
    /**
     * @ManyToOne(targetEntity="Profesor", inversedBy="iddca")
     * @JoinColumn(name="idProfesor", referencedColumnName="idProfesor")
     */
    protected $idProfesor;
    
    /**
    * @Column(type="string", length=250, nullable=false)
    */
    protected $descripcion;
    
    /**
    * @Column(type="string", length=100, nullable=false)
    */
    protected $descripcionCorta;
    
    /**
    * @Column(type="string", length=100, nullable=false)
    */
    protected $titulo;
    
    /**
     * @ManyToOne(targetEntity="Grupo", inversedBy="iddca")
     * @JoinColumn(name="idGrupo", referencedColumnName="idGrupo")
     */
    protected $idGrupo;
    
    /**
    * @Column(type="date", length=100, nullable=false)
    */
    protected $fecha;
    
    /**
    * @Column(type="string", length=200,  nullable=false)
    */
    protected $lugar;
    
    /**
    * @Column(type="time", length=100, nullable=false)
    */
    protected $horaInicial;
    
    /**
    * @Column(type="time", length=100, nullable=false)
    */
    protected $horaFinal;
    
    /**
    * @Column(type="string", length=200, nullable=true)
    */
    protected $fotoRepresentativaExcursion;
    
    public function getId() {
        return $this->id;
    }
    public function setId($id) {
        $this->id = $id;
        return $this;
    }

    public function getIdProfesor() {
        return $this->idProfesor;
    }
    public function setIdProfesor($idProfesor) {
        $idProfesor->addIddca($this);
        $this->idProfesor = $idProfesor;
    }
    
    public function getDescripcion() {
        return $this->descripcion;
    }
    public function setDescripcion($descripcion) {
        $this->descripcion = $descripcion;
        return $this;
    }
    
    public function getDescripcionCorta() {
        return $this->descripcionCorta;
    }
    public function setDescripcionCorta($descripcionCorta) {
        $this->descripcionCorta = $descripcionCorta;
        return $this;
    }
    
    public function getTitulo() {
        return $this->titulo;
    }
    public function setTitulo($titulo) {
        $this->titulo = $titulo;
        return $this;
    }
    
    public function getIdGrupo() {
        return $this->idGrupo;
    }
    public function setIdGrupo($idGrupo) {
        $idGrupo->addIddca($this);
        $this->idGrupo = $idGrupo;
    }
    
    public function getFecha() {
        return $this->fecha;
    }
    public function setFecha($fecha) {
        $this->fecha = $fecha;
        return $this;
    }
    
    public function getLugar() {
        return $this->lugar;
    }
    public function setLugar($lugar) {
        $this->lugar = $lugar;
        return $this;
    }
    
    public function getHoraInicial() {
        return $this->horaInicial;
    }
    public function setHoraInicial($horaInicial) {
        $this->horaInicial = $horaInicial;
        return $this;
    }
    
    public function getHoraFinal() {
        return $this->horaFinal;
    }
    public function setHoraFinal($horaFinal) {
        $this->horaFinal = $horaFinal;
        return $this;
    }
    
    public function getFotoRepresentativaExcursion() {
        return $this->fotoRepresentativaExcursion;
    }
    public function setFotoRepresentativaExcursion($fotoRepresentativaExcursion) {
        $this->fotoRepresentativaExcursion = $fotoRepresentativaExcursion;
        return $this;
    }
    
    function getArray(){
        $array = ["id" => $this->getId(), "titulo" => $this->getTitulo(), "descripcion" => $this->getDescripcion(), "descripcionCorta" => $this->getDescripcionCorta(), 
            "lugar" => $this->getLugar(), "fecha" => $this->getFecha()->format('Y-m-d'), "horaInicial" => $this->getHoraInicial()->format('H:i'), 
            "horaFinal" => $this->getHoraFinal()->format('H:i'), "FotoRepresentativa" => $this->getFotoRepresentativaExcursion(), 
            "idProfesor" => $this->getIdProfesor()->getIdProfesor(), "nombreProfesor" => $this->getIdProfesor()->getNombre(),  
            "departamentoProfesor" => $this->getIdProfesor()->getDepartamento(), "idGrupo" => $this->getIdGrupo()->getIdGrupo(), 
            "nombreGrupo" => $this->getIdGrupo()->getNombre()];
        return $array;
    }
}