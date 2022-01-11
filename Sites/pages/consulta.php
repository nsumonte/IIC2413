<?php include('../templates/header.php');   ?>

<body>

  <?php
  require("../config/conexion.php");
  $a = '';    
  if(isset($_POST['submit'])){
    if(!empty($_POST['artistas'])){

      foreach($_POST['artistas'] as $selected){
        $a .= $selected.",";
      }
    }
  }
  $fecha = $_POST['fecha'];
  $ciudad = $_POST['ciudad'];
  $result = $db -> prepare("SELECT itinerario($ciudad,'$a'::varchar,'$fecha');");
  $result -> execute();
  $dataCollected = $result -> fetchAll();
  $c = 1;
  foreach ($dataCollected as $d) {
    $p = explode(",", substr($d[0], 1));
    $preciot = substr($p[1], 0, -1);
    $viajes = explode('#',$p[0]);
    echo "Itinerario $c. Precio total $preciot<br>
    <table>
    <tr>
      <th scope='col'>Ciudad de origen</th>
      <th scope='col'>Ciudad de destino</th>
      <th scope='col'>Medio</th>
      <th scope='col'>Hora de salida</th>
      <th scope='col'>Duracion</th>
      <th scope='col'>Precio</th>
      <th scope='col'>Fecha</th>
    </tr>";
    foreach ($viajes as $viaje) {
        list($id, $origen, $destino, $medio, $hora, $duracion, $precio, $fecha) = explode("$", $viaje);
        echo"<tr><td>$origen</td><td>$destino</td><td>$medio</td><td>$hora</td><td>$duracion</td><td>$precio</td><td>$fecha</td></tr>";
    }
    echo"</table><br><br>";
    $c += 1; 
  }
  ?>