<?php
//check if input is setted
$path = '../../database/database_subjects.xml';
if(isset($_POST['name'])){
    // load XML database
	$xml =  simplexml_load_file($path);
	$nodes = selectSubject($xml);
	enrollStudent($nodes, $xml);
	validate($xml);
	persistXML($xml, $path);
    header('Location: ../success.xml');
}
else {
    echo('<html><body></body><a href="enrollStudentToSubject.xml">back</a><p>');
    echo('Nicht alle Felder sind gesetzt!</p></body></html>');
}

function selectSubject($xml){
	$name = $_POST['name'];
	return $xml->xpath("//subject[@name = '$name']/enrolledStudents/student");
}

function enrollStudent($nodes, $xml){
    //add student
    if(empty($_POST['id'])){
        foreach($nodes as $element){
            unset($element[0]);
        }
    }else{
        $array = [];
        foreach($nodes as $element){
            $node = $element->attributes()['id'];
            if(!in_array(intval($node), $_POST['id'])){
                unset($element[0]);
            }else{
                array_push($array, $node);
            }
        }
        $name = $_POST['name'];
        $nodes = $xml->xpath("//subject[@name = '$name']/enrolledStudents");
        foreach($_POST['id'] as $element){
            if(!in_array(intval($element), $array)){
                foreach($nodes as $node){
                    $node = $node->addChild('student');
                    $node->addAttribute('id', $element);
                }
            }
        }
    }
}

function validate($xml){
    //validate schema
    libxml_use_internal_errors(true);
    $dom = dom_import_simplexml($xml)->ownerDocument;
    if(!$dom){
        libxml_use_internal_errors(false);
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
    //persist
	$domxml = new DOMDocument('1.0');
	$domxml->preserveWhiteSpace = false;
	$domxml->formatOutput = true;
	$domxml->loadXML($xml->asXML());
	$domxml->save($path);
}

function printErrors()
{
    echo('<html><body></body><a href="enrollStudentToSubject.xml">back</a><p>');
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