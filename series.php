<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="series_styles.css">
    <title>Liste des Tables de la Base de Données</title>
</head>
<body>
    <h2>Liste des Tables de la Base de Données "Series"</h2>
    <?php
    // Connexion à la base de données
    $servername = "localhost";
    $username = "root"; 
    $password = ""; 
    $dbname = "series";

    $conn = new mysqli($servername, $username, $password, $dbname);

    // Vérifier la connexion
    if ($conn->connect_error) {
        die("La connexion a échoué : " . $conn->connect_error);
    }

    // Récupérer la liste des tables
    $sql = "SHOW TABLES FROM $dbname";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Tables</th></tr>";
        while($row = $result->fetch_assoc()) {
            echo "<tr><td><a href='?table=" . $row["Tables_in_$dbname"] . "'>" . $row["Tables_in_$dbname"] . "</a></td></tr>";
        }
        echo "</table>";

        // Afficher le contenu de la table sélectionnée
        if(isset($_GET['table'])) {
            $table = $_GET['table'];
            $sql_content = "SELECT * FROM $table";
            $result_content = $conn->query($sql_content);

            if ($result_content->num_rows > 0) {
                echo "<h2>Contenu de la Table \"$table\"</h2>";
                echo "<table>";
                $first_row = true;
                while($row_content = $result_content->fetch_assoc()) {
                    if($first_row) {
                        echo "<tr>";
                        foreach ($row_content as $key => $value) {
                            echo "<th>$key</th>";
                        }
                        echo "</tr>";
                        $first_row = false;
                    }
                    echo "<tr>";
                    foreach ($row_content as $value) {
                        echo "<td>$value</td>";
                    }
                    echo "</tr>";
                }
                echo "</table>";
            } else {
                echo "Aucun enregistrement trouvé dans la table \"$table\"";
            }
        }

        //jointures
        if(isset($_GET['join1']) && isset($_GET['join2'])) {
            $join1 = $_GET['join1'];
            $join2 = $_GET['join2'];
            
            if (isset($_GET['double_join']) && $_GET['double_join'] == 'on') {
                if ($join1 == 'genres' and $join2 =='critiques') {
                    $sql_join = "SELECT serie.*, genres.genre AS genre_nom, critiques.note_public, critiques.note_tomaters FROM serie INNER JOIN genres ON serie.id_genre = genres.id
                    INNER JOIN critiques ON serie.id = critiques.id_serie";
                } elseif ($join1 == 'critiques' and $join2 == 'genres') {
                    $sql_join = "SELECT serie.*, critiques.note_public, critiques.note_tomaters, genres.genre AS genre_nom FROM serie INNER JOIN critiques ON serie.id = critiques.id_serie
                    INNER JOIN genres ON serie.id_genre = genres.id"; }
            } else {
                if ($join1 == 'genres' ) {
                    $sql_join = "SELECT serie.*, genres.genre AS genre_nom FROM serie INNER JOIN genres ON serie.id_genre = genres.id";
                } elseif ($join1 == 'critiques') {
                    $sql_join = "SELECT serie.*, critiques.note_public, critiques.note_tomaters FROM serie INNER JOIN critiques ON serie.id= critiques.id_serie"; }
            }
            
            $result_join = $conn->query($sql_join);

            if ($result_join->num_rows > 0) {
                echo "<h2>Contenu de la Jointure \"$join1\"";
                if (isset($_GET['double_join']) && $_GET['double_join'] == 'on') {
                    echo " et \"$join2\"";
                }
                echo "</h2>";
                echo "<table>";
                $first_row = true;
                while($row_join = $result_join->fetch_assoc()) {
                    if($first_row) {
                        echo "<tr>";
                        foreach ($row_join as $key => $value) {
                            echo "<th>$key</th>";
                        }
                        echo "</tr>";
                        $first_row = false;
                    }
                    echo "<tr>";
                    foreach ($row_join as $value) {
                        echo "<td>$value</td>";
                    }
                    echo "</tr>";
                }
                echo "</table>";
            } else {
                echo "Aucun enregistrement trouvé dans la jointure \"$join1\"";
                if (isset($_GET['double_join']) && $_GET['double_join'] == 'on') {
                    echo " et \"$join2\"";
                }
            }
        }
    } else {
        echo "Aucune table trouvée dans la base de données";
    }


    $conn->close();
    ?>

    <form action="" method="get">
        <label for="join1">Première Jointure :</label>
        <select name="join1" id="join1">
            <option value="genres">Genres</option>
            <option value="critiques">Critiques</option>
        </select>

        <label for="double_join">Deuxième Jointure :</label>
        <input type="checkbox" name="double_join" id="double_join">

        <label for="join2">Avec :</label>
        <select name="join2" id="join2">
            <option value="genres">Genres</option>
            <option value="critiques">Critiques</option>
        </select>

        <button type="submit">Joindre</button>
    </form>
</body>
</html>





