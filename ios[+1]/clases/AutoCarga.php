<?php

class AutoCarga {
    static function load($clase) {
        $carpetas = array(
            '/',
            '/controlador/',
            '/datos/',
            '/doctrine/',
            '/gestores/',
            '/modelo/',
            '/rest/'
        );
        foreach($carpetas as $carpeta){
            $archivo = __DIR__ . $carpeta .  $clase . '.php';
            if(file_exists($archivo)){
                require_once $archivo;
                return;
            }
        }
    }
}

spl_autoload_register('AutoCarga::load');