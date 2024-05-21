<?php
class conexion{
    public function conectar(){
    //define: definir variables
        define('server',"localhost");
        define('db',"quinto");
        define('user',"root");
        define('password',"");
        //PDO: Obliga a mandar el tipo de caracteres a manejar en la bd
        //:: Acceder a un atributo estatico -> atributo directo de una clase
        $opc = array(PDO::MYSQL_ATTR_INIT_COMMAND> 'SET NAMES utf8');
        try{
            $con=new PDO("mysql:host=".server.";dbname=".db,user,password,$opc);
            return $con;
        } catch(Exception $e){
            die("Error en la conexión: ".$e->getMessage());
        }
    }
}