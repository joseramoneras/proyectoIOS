<?php
use Doctrine\Common\Collections\ArrayCollection;
    /**
     * @Entity 
     * @Table(name="grupo")
     **/
    class Grupo {
        /**
         * @Id
         * @Column(type="integer") @GeneratedValue
         */
        protected $idGrupo;
        
        /**
         * @Column(type="string", length=100, unique=true, nullable=false)
         */
        protected $nombre;
        
        /**
         * @OneToMany(targetEntity="Actividad", mappedBy="grupo")
         */
        protected $iddca = null;
        
        public function __construct() {
            $this->iddca = new ArrayCollection();
        }
    
        
        //métodos getter y setter
        public function getIdGrupo() {
            return $this->idGrupo;
        }
        public function setIdGrupo($idGrupo) {
            $this->idGrupo = $idGrupo;
            return $this;
        }
        public function getNombre() {
            return $this->nombre;
        }
        public function setNombre($nombre) {
            $this->nombre = $nombre;
            return $this;
        }
        function __toString(){
            return $this->getId() . ' ' . $this->getNombre();
        }
        public function addIddca($iddca){
            $this->iddca[] = $iddca;
        }
        
        function getArray(){
            $array = ["id" => $this->getIdGrupo(), "nombreGrupo" => $this->getNombre()];
            return $array;
        }
    }