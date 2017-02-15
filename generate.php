<?php

$recordsNum = 1000 * 1000;
$commitAfter = 10 * 1000;

class ArrayGenerator
{
	public $array = null;
	public $arrayCount = null;
	
	function __construct ($array)
	{
		$this->array = $array;
		$this->arrayCount = count($this->array);
	}
	function generate($i) {
		return $this->array[$i % $this->arrayCount];
	}
}

class MethodGenerator
{
	function __construct ()
	{
		$this->methods = new ArrayGenerator(array('GET', 'POST', 'PUT', 'DELETE'));
	}
	function generate($i) {
		return $this->methods->generate($i);
	}
}
$methodGenerator = new MethodGenerator();

class UrlGenerator
{
	function __construct ()
	{
		$this->dirs = new ArrayGenerator(array('circulation', 'inventory', 'settings'));
		$this->resources = new ArrayGenerator(array('reader', 'holding', 'document', 'periodical', 'loss'));
	}
	function generate($i) {
		return "/".$this->dirs->generate($i / ($this->resources->arrayCount + 2))."/".$this->resources->generate($i);
	}
}
$urlGenerator = new UrlGenerator();

function ipGenerator($i) {
	return (($i/(256*256*256))%256).".".(($i/(256*256))%256).".".(($i/256)%256).".".($i%256);
}

$fp = fopen("insert_{$recordsNum}.ms.sql", 'w');
fwrite($fp, 
	"\nBEGIN TRANSACTION; "
);
for ($i = 0; $i < $recordsNum; $i++) {
	fwrite($fp, "\nINSERT INTO alog (ip,deltaT,method,url) VALUES ('".ipGenerator($i)."',".($i).",'".$methodGenerator->generate($i)."','".$urlGenerator->generate($i)."'); ");
	if (($i % $commitAfter === $commitAfter - 1) && ($i < $recordsNum - 1)) {
		fwrite($fp, 
			"\nCOMMIT; "
			.
			"\nGO "
			.
			"\nBEGIN TRANSACTION; "
		);
		
	}
}
fwrite($fp,
	"\nCOMMIT; "
);
fclose($fp);