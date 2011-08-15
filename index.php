<?php
	require_once 'bootstrap.php' ;

	$app = new Silex\Application();

	$app->get('/', function() use($app) {
		return 'Hey.' ; 
	}); 

	$app->run(); 

?>