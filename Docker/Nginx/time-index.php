<?php

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