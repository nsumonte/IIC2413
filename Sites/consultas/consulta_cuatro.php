<?php 
	//carga la plantilla con la header y el footer
	include('../templates/layout.php');	
 ?>

<body>
<?php
  #Llama a conexión, crea el objeto PDO y obtiene la variable $db
  require("../config/conexion.php");
  $id_usuario = $_POST["id_usuario"]; 

        $query = "SELECT sum(destinos.precio) FROM usuarios,tickets,destinos WHERE usuarios.uid = tickets.uid AND tickets.did = destinos.did AND usuarios.uid = $id_usuario;";
        $result = $db -> prepare($query);
        $result -> execute();
        $usuarios = $result -> fetchAll();
  ?>
  <div class="container">
    <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Cantidad total gastada</th>
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
