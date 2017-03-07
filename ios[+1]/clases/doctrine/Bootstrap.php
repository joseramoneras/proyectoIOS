<?php

use Doctrine\ORM\Tools\Setup;
use Doctrine\ORM\EntityManager;

class Bootstrap {

    private $config;
    private $conexion = array(
        'driver'   => 'pdo_mysql',
        'host'     => '127.0.0.1',
        'dbname'   => 'aplicacion_ios',
        'user'     => 'userProyecto',
        'password' => 'UserProyecto'
    );
    private $entityManager;
    private $isDevMode = true;
    
    function __construct() {
        $this->config = Setup::createAnnotationMetadataConfiguration(array(__DIR__ . '/src'), $this->isDevMode);
        $this->entityManager = EntityManager::create($this->conexion, $this->config);
    }

    function getEntityManager() {
        return $this->entityManager;
    }
}