<?php
//check if input is setted
$pathsubjects = '../../database/database_subjects.xml';
if(isset($_POST['name'])){
    // load XML database
	$xml = simplexml_load_file($pathsubjects);
	$nodes = findSubjects($xml);
	deleteSubject($nodes);
	validate($xml);
	persistXML($xml, $pathsubjects);
    header('Location: ../success.xml');
}
else {
    echo('<html><body></body><a href="removeSubject.xml">back</a><p>');
    echo('Nicht alle Felder sind gesetzt!</p></body></html>');
}

function findSubjects($xml){
    //add student
	$name = $_POST['name'];
    $nodes = $xml->xpath("//subject[@name = '$name']");
	return $nodes;

}

function deleteSubject($nodes){
	foreach($nodes as $element){
		unset($element[0]);
	}
}

function validate($xml){
    //validate schema
    libxml_use_internal_errors(true);
    $dom = dom_import_simplexml($xml)->ownerDocument;
    if(!$dom){
        printErrors();
    }else{
        $xsd = '../../database/database_subjects.xsd';
        $validation = $dom->schemaValidate($xsd);
        if($validation){
            libxml_use_internal_errors(false);
        }else{
            printErrors();
        }
    }
}

function persistXML($xml, $path){
    //persist
	$domxml = new DOMDocument('1.0');
	$domxml->preserveWhiteSpace = false;
	$domxml->formatOutput = true;
	$domxml->loadXML($xml->asXML());
	$domxml->save($path);
}
function printErrors()
{
    echo('<html><body></body><a href="removeSubject.xml">back</a><p>');
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