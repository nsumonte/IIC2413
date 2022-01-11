<?php 
	//carga la plantilla con la header y el footer
	include('../templates/layout.php');	
 ?>

<body>
<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");
  $pais_elegido = $_POST["pais"];

        $query = "SELECT ciudades.ciudad FROM ciudades,paises WHERE ciudades.pid = paises.pid AND nombre_pais LIKE LOWER('%$pais_elegido%');";
        $result = $db -> prepare($query);
        $result -> execute();
        $usuarios = $result -> fetchAll();
  ?>
  <div class="container">
    <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Ciudad</th>
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
