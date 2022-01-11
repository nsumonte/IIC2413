<?php include('templates/header.php');   ?>

<body>

    

  

  <?php
  #Primero obtenemos todos los tipos de pokemones
  require("config/conexion.php");
  $result = $db2 -> prepare("SELECT aid, anombre FROM artistas;");
  $result -> execute();
  $dataCollected = $result -> fetchAll();
  ?>
  <form action="pages/consulta.php" method="post" >

  <p>
  <h3 align="center">Artistas</h3> <br>
  <?php
  #Para cada tipo agregamos el tag <option value=value_of_param> visible_value </option>
  foreach ($dataCollected as $d) {
    
    echo "<label><input type='checkbox' name='artistas[]' value=$d[0]> $d[1]</label><br>";
  }
  require("config/conexion.php");
  $result = $db -> prepare("SELECT cid, ciudad FROM ciudades;");
  $result -> execute();
  $dataCollected = $result -> fetchAll();

  ?>
  <br><br>
  <select name="ciudad">
  <?php
  #Para cada tipo agregamos el tag <option value=value_of_param> visible_value </option>
  foreach ($dataCollected as $d) {
    $a = ucfirst($d[1]);
    echo "<option value=$d[0]> $a</option>";
  }
  ?>
  </select>
  <br><br>
  <input type="date" id="start" name="fecha"
       value="2020-06-01"
       min="2020-01-01" max="2020-12-31">

    
        
  <p><input type="submit" name="submit" value="Enviar datos"></p>

</form>
  
    
  <br>
  <br>
  <br>
  <br>
</body>
</html>