<?php
	require_once 'bootstrap.php' ;

	$app = new Silex\Application();


	$app->get('/', function() use ($app, $dm){
		
	}) ;

	$app->get('/{id}', function($id) use($app, $dm) {
		return "Hey, $id ." ; 
	}) ;

	$app->run(); 

?>