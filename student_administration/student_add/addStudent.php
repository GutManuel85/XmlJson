<?php
//check if input is setted
$path = '../../database/database_students.xml';
if (isset($_POST['firstName']) && isset($_POST['lastName']) && isset($_POST['birthDate']) && isset($_POST['gender'])) {
    // load XML database
    $xml = simplexml_load_file($path);
    $index = getIndex($xml);
    addStudent($xml, $index);
    validate($xml);
    persistXML($xml, $path);
    header('Location: ../success.xml');
}
else {
    echo('<html><body></body><a href="addStudent.xml">back</a><p>');
    echo('Nicht alle Felder sind gesetzt!</p></body></html>');
}

function getIndex($xml)
{
    //get max value of current existent index
    $result = $xml->xpath('//student/@id');
    $compare = -1;
    foreach($result as $element){
        if(intval($element) > $compare){
            $compare = $element;
        }
    }
    $compare+=1;
    return $compare;
}

function addStudent($xml, $index)
{
    //add student
    $node = $xml->addChild('student');
    $node->addAttribute('id', $index);
    $node->addChild('firstName', $_POST['firstName']);
    $node->addChild('lastName', $_POST['lastName']);
    $node->addChild('birthDate', $_POST['birthDate']);
    $node->addChild('gender', $_POST['gender']);
}

function validate($xml)
{
    //validate schema
    libxml_use_internal_errors(true);
    $dom = dom_import_simplexml($xml)->ownerDocument;
    if (!$dom) {
        printErrors();
    }
    else {
        $xsd = '../../database/database_students.xsd';
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
    echo('<html><body></body><a href="addStudent.xml">back</a><p>');
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