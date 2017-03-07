<?php
use Doctrine\Common\Collections\ArrayCollection;
    /**
     * @Entity 
     * @Table(name="profesor")
     **/
    class Profesor {
        /**
         * @Id
         * @Column(type="integer") @GeneratedValue
         */
        protected $idProfesor;
        /**
         * @Column(type="string", length=100, unique=false, nullable=false)
         */
        protected $nombre;
        /**
         * @Column(type="string", length=50, nullable=true)
         */
        protected $departamento;
        
        /**
         * @OneToMany(targetEntity="Actividad", mappedBy="profesor")
         */
        protected $iddca = null;
        
        public function __construct() {
            $this->iddca = new ArrayCollection();
        }
    
        
        //métodos getter y setter
        public function getIdProfesor() {
            return $this->idProfesor;
        }
        public function setIdProfesor($idProfesor) {
            $this->idProfesor = $idProfesor;
            return $this;
        }
        public function getNombre() {
            return $this->nombre;
        }
        public function setNombre($nombre) {
            $this->nombre = $nombre;
            return $this;
        }
        public function getDepartamento() {
            return $this->departamento;
        }
        public function setDepartamento($departamento) {
            $this->departamento = $departamento;
            return $this;
        }
        function __toString(){
            return $this->getIdProfesor() . ' ' . $this->getNombre();
        }
        
        public function addIddca($iddca){
            $this->iddca[] = $iddca;
        }
        public function getIddca(){
            return $this->addIddca;
        }
        
        function getArray(){
            $array = ["id" => $this->getIdProfesor(), "nombreProfesor" => $this->getNombre(), "departamentoProfesor" => $this->getDepartamento()];
            return $array;
        }
    }