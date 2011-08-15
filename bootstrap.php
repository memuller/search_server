<?php 
	define('APP_ROOT', getcwd());
	require_once APP_ROOT . '/vendors/doctrine_mongo/lib/vendor/doctrine-common/lib/Doctrine/Common/ClassLoader.php';
	require_once 'vendors/bootstrapers/doctrine.php';

	use Doctrine\Common\ClassLoader ;

	# loads all models.
	$classLoader = new ClassLoader('Models', APP_ROOT . '/models') ;
	$classLoader->register();

 ?>