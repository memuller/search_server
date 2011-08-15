<?php
	namespace Models ;
	use Doctrine\ODM\MongoDB\Mapping\Annotations as Mongo ;
	/** @Mongo\Document */
	class Document{
	
		/** @Mongo\Id */
		public $id ;
		
		/** @Mongo\String */
		public $title ;

		/** @Mongo\String */
		public $url ;

		public function __construct($url){
			$this->url = $url ;
		}
	}
?>