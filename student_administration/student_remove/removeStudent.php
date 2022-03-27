<?php
//check if input is setted
$pathstudents = '../../database/database_students.xml';
$pathsubjects = '../../database/database_subjects.xml';
if (isset($_POST['id'])) {
    // load XML database
    $xmlstudents = simplexml_load_file($pathstudents);
    $xmlsubjects = simplexml_load_file($pathsubjects);
    $nodes = findStudent($xmlstudents);
    deleteStudent($nodes);
    $nodes = findGrades($xmlsubjects);
    deleteGrades($nodes);
    $xsdstudents = '../../database/database_students.xsd';
    validate($xmlstudents, $xsdstudents);
    $xsdsubjects = '../../database/database_subjects.xsd';
    validate($xmlsubjects, $xsdsubjects);
    persistXML($xmlstudents, $pathstudents);
    persistXML($xmlsubjects, $pathsubjects);
    header('Location: ../success.xml');
}
else {
    echo('<html><body></body><a href="removeStudent.xml">back</a><p>');
    echo('Nicht alle Felder sind gesetzt!</p></body></html>');
}


function findStudent($xml)
{
    $id = $_POST['id'];
    $nodes = $xml->xpath("//student[@id = '$id']");
    return $nodes;

}

function deleteStudent($nodes)
{
    foreach ($nodes as $element) {
        unset($element[0]);
    }
}

function findGrades($xml)
{
    $id = $_POST['id'];
    $nodes = $xml->xpath("//student[@id = '$id']");
    return $nodes;

}

function deleteGrades($nodes)
{
    foreach ($nodes as $element) {
        unset($element[0]);
    }
}

function validate($xml, $xsd)
{
    //validate schema
    libxml_use_internal_errors(true);
    $dom = dom_import_simplexml($xml)->ownerDocument;
    if (!$dom) {
        printErrors();
    }
    else {
        $validation = $dom->schemaValidate($xsd);
        if ($validation) {
            libxml_use_internal_errors(false);
        }
        else {
            printErrors();
        }
    }
}

function persistXML($xml, $path)
{
    //persist
    $domxml = new DOMDocument('1.0');
    $domxml->preserveWhiteSpace = false;
    $domxml->formatOutput = true;
    $domxml->loadXML($xml->asXML());
    $domxml->save($path);
}

function printErrors()
{
    echo('<html><body></body><a href="removeStudent.xml">back</a><p>');
    $ret = array();
    $errors = libxml_get_errors();
    foreach ($errors as $error) {
        $ret[] = sprintf('Line [%d]: %s', $error->line, $error->message);
    }
    libxml_clear_errors();
    $errors = implode('</br>', $ret);
    print($errors);
    echo('</p></body></html>');
    libxml_use_internal_errors(false);
    exit();
}


?>