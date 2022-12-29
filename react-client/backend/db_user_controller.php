<?php
require('./dbconnection.php');

function registerUser($uname, $pw){
    $db = createDbConnection();

    $pw = password_hash($pw, PASSWORD_DEFAULT);

    $sql = "INSERT INTO user (username, passwd) VALUES (?,?)";
    $statement = $db->prepare($sql);
    $statement->execute(array($uname, $pw));
}
function checkUser($uname, $pw){
    $db = createDbConnection();

    $sql = "SELECT passwd FROM user WHERE username=?";
    $statement = $db->prepare($sql);
    $statement->execute(array($uname));

    $hashedpw = $statement->fetchColumn();

    if(isset($hashedpw)){
        return password_verify($pw, $hashedpw) ? $uname : null;
    }

    return null;
}
function getUserMessages($uname){
    $db = createDbConnection();

    $sql = "SELECT msg FROM message WHERE username=?";
    $statement = $db->prepare($sql);
    $statement->execute(array($uname));

    return $statement->fetchAll(PDO::FETCH_COLUMN,0);
}