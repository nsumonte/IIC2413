<?php 
	//carga la plantilla con la header y el footer
	include('../templates/layout.php');	
 ?>

<body>
<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");

  $id_nuevo = $_POST["id_elegido"];

 	$query = "SELECT username, correo FROM usuarios;";
	$result = $db -> prepare($query);
	$result -> execute();
	$usuarios = $result -> fetchAll();
  ?>
  <div class="container">
    <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Username</th>
          <th scope="col">Correo</th>
        </tr>
      </thead>
      <tbody>
        <tr>
        <?php
            foreach ($usuarios as $usuario) {
                echo "<tr><td>$usuario[0]</td><td>$usuario[1]</td></tr>";
            }
        ?>
        </tr>
      </tbody>
    </table>
  </div>

<?php include('../templates/footer.php'); ?>
