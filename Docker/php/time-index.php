<?php

class MyDateTime extends \DateTime implements \JsonSerializable
{
    public function jsonSerialize()
    {
       return $this->format("c");
    }
}

$datetime = new MyDatetime();

$output = [
    'UTC' => $datetime,
];

echo json_encode($output);

$data = array( 
	"first" => "a",
        "second" => "b",
        "third" => "c" );
$head = array( 
	"fromHead"=> "x");

echo  nl2br ("\n");
echo $output;


echo  nl2br ("\n");
echo $data;
echo  nl2br ("\n");
echo json_encode( $data );

//$dateNY = new DateTime("now", new DateTimeZone('America/New_York') );
//echo $dateNy->format('Y-m-d H:i:s');

date_default_timezone_set('America/New_York');


$datetimeNY = new MyDatetime();

$outputNY = [
    'New York' => $datetimeNY,
];

echo json_encode($outputNY);

echo  nl2br ("\n");
echo "New York time: ";
echo date('H:i:s');

date_default_timezone_set('Europe/Berlin');
echo  nl2br ("\n");
echo "Berlin time: ";
echo date('H:i:s');

date_default_timezone_set('Asia/Tokyo');
echo  nl2br ("\n");
echo "Tokyo time: ";
echo date('H:i:s');

//echo date('Y-m-d H:i:s');