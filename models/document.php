<?php
	namespace Models ;
	use Doctrine\ODM\MongoDB\Mapping\Annotations as Mongo ;
	/** @Mongo\Document */
	class Document{
	
		/** @Mongo\Id */
		public $id ;
		
		/** @Mongo\String @Mongo\Index(unique=true) */
		public $url ;

		/** @Mongo\String @Mongo\Index */
		public $title ;

		/** @Mongo\String */
		public $description ;

		/** @Mongo\String */
		public $author ;

		/** @Mongo\String */
		public $category ;

		/** @Mongo\Timestamp */
		public $createdAt ;

		/** @Mongo\Array @Mongo\Index */
		public $tags ;

		public function __construct($url){
			$this->url = $url ;
		}
	}
?>