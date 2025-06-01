<h3>Docker Tutorial</h3>
<div class=".db-table">
    <table>
        <tr>
            <th>Id</th>
            <th>Message</th>
        </tr>
        <?php

        $env = file_get_contents("/deployments/.env");

        //var_dump($env);

        $lines = explode("\n",$env);

        foreach($lines as $line){
          preg_match("/([^#]+)\=(.*)/",$line,$matches);
          if(isset($matches[2])){ putenv(trim($line)); }
        }

        //var_dump(getenv());

        $user = getenv("DB_USER");
        $pass = getenv("DB_PASS");

        try {
            $dbh = new PDO('mysql:host=db;port=3306;dbname=app', $user, $pass);
            foreach ($dbh->query('SELECT * from message') as $row) {
                $html = "<tr><td>${row['id']}</td><td>${row['message']}</td></tr>";
                echo $html;
            }
            $dbh = null;
        } catch (PDOException $e) {
            print "Error!: " . $e->getMessage() . "<br/>";
            die();
        }
        ?>
    </table>
</div>