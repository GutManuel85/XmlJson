<?php
//check if input is setted
$path = '../../database/database_subjects.xml';
if (isset($_POST['id']) && isset($_POST['name']) && isset($_POST['date']) && isset($_POST['mark']) && isset($_POST['feedback'])) {
    // load XML database
    $xml = simplexml_load_file($path);
    $nodes = selectStudentAndSubject($xml);
    addGrade($nodes);
    validate($xml);
    persistXML($xml, $path);
    header('Location: ../success.xml');
}
else {
    echo('<html><body></body><a href="addGrade.xml">back</a><p>');
    echo('Nicht alle Felder sind gesetzt!</p></body></html>');
}

function selectStudentAndSubject($xml)
{
    $id = $_POST['id'];
    $name = $_POST['name'];
    return $xml->xpath("//subject[@name = '$name']/enrolledStudents/student[@id = '$id']");
}

function addGrade($nodes)
{
    //add student
    if(count($nodes)==0){
        echo('<html><body></body><a href="addGrade.xml">back</a><p>');
        echo('Student ist nicht für diese Fach angemeldet</p></body></html>');
        exit();
    }
    foreach ($nodes as $element) {
        $node = $element->addChild('grade');
        $node->addAttribute('date', $_POST['date']);
        $node->addChild('mark', $_POST['mark']);
        $node->addChild('feedback', $_POST['feedback']);
    }
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
        $xsd = '../../database/database_subjects.xsd';
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
    //persist
    $domxml = new DOMDocument('1.0');
    $domxml->preserveWhiteSpace = false;
    $domxml->formatOutput = true;
    $domxml->loadXML($xml->asXML());
    $domxml->save($path);
}
function printErrors()
{
    echo('<html><body></body><a href="addGrade.xml">back</a><p>');
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