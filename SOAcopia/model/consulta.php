<?php
include_once 'conexion.php';

class crudS{
    public static function seleccionarEstudiantes(){
        $object = new conexion();
        $conn = $object->conectar();
        $sqlSelect= "select * from estudiante";
        $result = $conn->prepare($sqlSelect);
        $result->execute();
        $data =$result->fetchAll(PDO::FETCH_ASSOC);
        $dataJs = json_encode($data);
        print_r($dataJs);
    }
    // public static function seleccionarEstudiantes($cedula){
    //     $object = new conexion();
    //     $conn = $object->conectar();
    //     $sqlSelect= "select * from estudiantes where direccion ='$cedula'";
    //     $result = $conn->prepare($sqlSelect);
    //     $result->execute();
    //     $data =$result->fetchAll(PDO::FETCH_ASSOC);
    //     $dataJs = json_encode($data);
    //     print_r($dataJs);
    // }
}