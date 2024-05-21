<?php
include_once 'conexion.php';

class CrudG{
    public static function guardarEstudiante($cedula,$nombre,$apellido, $direccion, $telefono){
        $object = new conexion();
        $conectar = $object->conectar();
        $insert = "insert into estudiante values('$cedula','$nombre','$apellido', '$direccion', '$telefono')";
        $result= $conectar->prepare($insert);
        $result->execute();
        $dataJs = json_encode($result);
        print_r($dataJs);
        //echo json_encode($result);
        $conectar->commit();
    }
}