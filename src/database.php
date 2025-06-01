<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Docker Tutorial</title>
    <meta name="description" content="Learn how to use Docker with PHP">
    <meta name="author" content="Matthew Parris">
</head>

<body>
    <h1>Docker Tutorial</h1>
    <div class=".db-table">
        <table>
            <tr>
                <th>Id</th>
                <th>Message</th>
            </tr>
            <?php
            $user = 'root';
            $pass = '';

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
</body>

</html>