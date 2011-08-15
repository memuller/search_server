<?php

use Doctrine\Common\ClassLoader,
	Doctrine\ODM\MongoDB\DocumentManager,
	Doctrine\MongoDB\Connection,
	Doctrine\ODM\MongoDB\Configuration,
	Doctrine\ODM\MongoDB\Mapping\Driver\AnnotationDriver,
	Doctrine\Common\Annotations\AnnotationReader
;


$classLoader = new ClassLoader('Doctrine\ODM\MongoDB', APP_ROOT . '/vendors/doctrine_mongo/lib');
$classLoader->register();

$classLoader = new ClassLoader('Doctrine\MongoDB', APP_ROOT . '/vendors/doctrine_mongo/lib/vendor/doctrine-mongodb/lib');
$classLoader->register();

$classLoader = new ClassLoader('Doctrine', APP_ROOT . '/vendors/doctrine_mongo/lib/vendor/doctrine-common/lib');
$classLoader->register();

$classLoader = new ClassLoader('Symfony\Component\Yaml', APP_ROOT . '/vendors/doctrine_mongo/lib/vendor');
$classLoader->register();

AnnotationDriver::registerAnnotationClasses();

$config = new Configuration();
$config->setProxyDir(__DIR__ . '/cache');
$config->setProxyNamespace('Proxies');

$config->setHydratorDir(__DIR__ . '/cache');
$config->setHydratorNamespace('Hydrators');

$reader = new AnnotationReader();
//$reader->setDefaultAnnotationNamespace('Doctrine\ODM\MongoDB\Mapping\\');
$config->setMetadataDriverImpl(new AnnotationDriver($reader, 'models'));

$dm = DocumentManager::create(new Connection(), $config);