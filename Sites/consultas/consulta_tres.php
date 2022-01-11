<?php 
	//carga la plantilla con la header y el footer
	include('../templates/layout.php');	
 ?>

<body>
<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");
  $username = $_POST["username_hoteles"];

        $query = "SELECT distinct paises.nombre_pais FROM  usuarios,reservas,hoteles,ciudades,paises WHERE usuarios.uid = reservas.uid AND hoteles.hid = reservas.hid AND ciudades.cid = hoteles.cid AND ciudades.pid = paises.pid AND reservas.fecha_salida < current_date AND username LIKE LOWER('%$username%');";
        $result = $db -> prepare($query);
        $result -> execute();
        $usuarios = $result -> fetchAll();
  ?>
  <div class="container">
    <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Paises</th>
        </tr>
      </thead>
      <tbody>
        <tr>
        <?php
            foreach ($usuarios as $usuario) {
                echo "<tr><td>$usuario[0]</td></tr>";
            }
        ?>
        </tr>
      </tbody>
    </table>
  </div>

<?php include('../templates/footer.php'); ?>
