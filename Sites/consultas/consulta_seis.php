<?php 
	//carga la plantilla con la header y el footer
	include('../templates/layout.php');	
 ?>

<body>
<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");
  $fecha_inicio = $_POST["fecha_inicio"]; 
  $fecha_termino = $_POST["fecha_termino"];

        $query = "SELECT usuarios.uid,usuarios.nombreusuario, sum(destinos.precio) FROM usuarios,tickets,destinos WHERE usuarios.uid = tickets.uid AND tickets.did = destinos.did AND fechacompra >= '$fecha_inicio'  AND fechacompra <= '$fecha_termino' group by usuarios.uid ;";
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
          <th scope="col">Dinero gastado</th>
        </tr>
      </thead>
      <tbody>
        <tr>
        <?php
            foreach ($usuarios as $usuario) {
                echo "<tr><td>$usuario[0]</td><td>$usuario[1]</td><td>$usuario[2]</td></tr>";
            }
        ?>
        </tr>
      </tbody>
    </table>
  </div>

<?php include('../templates/footer.php'); ?>
