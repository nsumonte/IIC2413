<?php 
	//carga la plantilla con la header y el footer
	include('../templates/layout.php');	
 ?>

<body>
<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");
  $id_usuario = $_POST["id_usuario"]; 

        $query = "SELECT  usuarios.uid, usuarios.username, hoteles.nombrehotel, reservas.fecha_llegada, reservas.fecha_salida FROM  usuarios,hoteles,reservas WHERE usuarios.uid = reservas.uid AND reservas.hid = hoteles.hid AND fecha_llegada >= '2020-01-01' AND  fecha_salida <'2020-03-31';";
        $result = $db -> prepare($query);
        $result -> execute();
        $usuarios = $result -> fetchAll();
  ?>
  <div class="container">
    <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Identificador</th>
          <th scope="col">Nombre de usuario</th>
          <th scope="col">Nombre del hotel</th>
          <th scope="col">Fecha de inicio</th>
          <th scope="col">Fecha de termino</th>
        </tr>
      </thead>
      <tbody>
        <tr>
        <?php
            foreach ($usuarios as $usuario) {
                echo "<tr><td>$usuario[0]</td><td>$usuario[1]</td><td>$usuario[2]</td><td>$usuario[3]</td><td>$usuario[4]</td></tr>";
            }
        ?>
        </tr>
      </tbody>
    </table>
  </div>

<?php include('../templates/footer.php'); ?>
