<?php
 include_once 'conexion.php';

 class CrudM{
     public static function modificarEstudiante($cedula, $nombre, $apellido, $direccion, $telefono){
         $object = new conexion();
         $conectar = $object->conectar();
         $update = "update estudiante set nombre='$nombre',apellido='$apellido', direccion='$direccion', telefono='$telefono' where cedula='$cedula'";
         $result= $conectar->prepare($update);
         $result->execute();
         echo json_encode($result);
         $conectar->commit();
     }
 }