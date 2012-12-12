<?php
/*
// Kinesphère "Kirousel" Plugin for Joomla! 1.5.x - Version 1.1
// License: http://www.gnu.org/copyleft/gpl.html
// Copyright (c) 2009 Kinesphère
// More info at http://www.kinesphere.fr/kirousel
*/

// no direct access
defined( '_JEXEC' ) or die( 'Restricted access' );

class plgContentkirousel extends JPlugin
{
	//Constructeur
	function plgContentkirousel( &$subject )
	{
		parent::__construct( $subject );
		// load plugin parameters
		$this->_plugin = JPluginHelper::getPlugin( 'content', 'kirousel' );
		$this->_params = new JParameter( $this->_plugin->params );
	}


	function onPrepareContent(&$row, &$params, $limitstart) {

		// just startup
		global $mainframe;

		// checking
		if ( !preg_match("#\[kirousel\]#s", $row->text) && !preg_match("#\[/kirousel\]#s", $row->text) ) {
			return;
		}

		$plugin =& JPluginHelper::getPlugin('content', 'kirousel');
		$pluginParams = new JParameter( $plugin->params );

		// j!1.5 paths
		$mosConfig_absolute_path 	= JPATH_SITE;
		$mosConfig_live_site 		= $mainframe->isAdmin() ? $mainframe->getSiteURL() : JURI::base();
		if(substr($mosConfig_live_site, -1)=="/") $mosConfig_live_site = substr($mosConfig_live_site, 0, -1);

		// Paramètres
		$dossier 		= $pluginParams->get('kirousel_dossier', 'images/kirousel/');
		$effet 			= $pluginParams->get('kirousel_effet', 'horiz ');
		$boucle 		= $pluginParams->get('kirousel_boucle', '0');
		$item[0] 		= $pluginParams->get('kirousel_item', '1');
		$pagination [0]	= $pluginParams->get('kirousel_pagination', '0');
		$defil		 	= $pluginParams->get('kirousel_defil', '1');
		$delais		 	= $pluginParams->get('kirousel_delais', '5000');				

		// on vérifie un peu l'adresse du dossier
		if (!preg_match("#/$#", $dossier)) $dossier = $dossier . "/";
		if (preg_match("#^/#", $dossier))  $dossier = preg_replace('#^/(.+)#i', '$1', $dossier);

		// Paramètres du js
		$js_params_start = "{ ";
		$js_params .= ', nextBtn: \'<img src="plugins/content/plugin_kirousel/next.png" alt="next" width="30" height="30" />\', prevBtn: \'<img src="plugins/content/plugin_kirousel/prev.png" alt="previous" width="30" height="30" />\'';
		$js_params_end = " }";

		// indentifiant unique
		if ($row->alias !="" ) $alias = $row->alias;
		else $alias = JFilterOutput::stringURLSafe($row->title);
;
		// le HEADER !!
		$doc =& JFactory::getDocument();
		$headerstuff = $doc->getHeadData();
		$headerstuff['scripts'][JURI::base( true )."/plugins/content/plugin_kirousel/kirousel-jquery.js"] = "text/javascript";
		$headerstuff['scripts'][JURI::base( true )."/plugins/content/plugin_kirousel/kirousel-jquery-easing.js"] = "text/javascript";
		//$headerstuff['styleSheets'][JURI::base( true )."/plugins/content/plugin_kirousel/kirousel.css"] = 'text/css';
		$doc->setHeadData($headerstuff);
		$doc->addStyleSheet('plugins/content/plugin_kirousel/kirousel.css');
				
/*
	<script type=\"text/javascript\" src=\"$mosConfig_live_site/plugins/content/plugin_kirousel/kirousel-jquery.js\"></script>
	<script type=\"text/javascript\" src=\"$mosConfig_live_site/plugins/content/plugin_kirousel/kirousel-jquery-easing.js\"></script>	
*/
		$header = "<!-- Kinesphère \"Kirousel\" Plugin (v1.0) starts here -->
";
		// paramètres internes
		preg_match_all("#\[kirousel](.+?)\[/kirousel]#s",$row->text, $regs, PREG_SET_ORDER  );
		$header .= "	<script type='text/javascript'>
	/* <![CDATA[ */ $(function(){
";
		for($i = 0; $i < count($regs); $i++) {
			// paramètres par défaut __________________________________________________________
			$item[$i] = $pluginParams->get('kirousel_item', '1');
			$pagination [$i]	= $pluginParams->get('kirousel_pagination', '0');
			$defil 	= $pluginParams->get('kirousel_defil', '1');			
	
			switch ($effet) {
				case "vert" 	: $js_params_effet = 'direction: "vertical"'; break;
				case "fondu" 	: $js_params_effet = 'effect: "fade"'; break;
				case "rebond" 	: $js_params_effet = 'slideEasing: "easeOutBounce"'; break;
				default		 	: $js_params_effet = 'direction: "horizontal"'; break;				
			}
			
			if ($boucle == 0) 			$js_params 			.= ", loop: true";
			if ($item[$i] > 1) 			$js_params_item 	 = ", dispItems: ".$item[$i];
			if ($pagination[$i] == 1)	$js_params_pag 		 = ", pagination: true";
			else $js_params_pag = "";
			if ($defil == 1)			$js_params_diapo 	 = ", autoSlide: true, autoSlideInterval: ".$delais.", delayAutoSlide: ".$delais;
			else $js_params_diapo = "";			
			
			// on vérifie s'il y a des paramètres particuliers _______________________________
			$parames =  $regs[$i][1];
			$parames = explode(",", $parames);
			if (count($parames) > 3) {
				for ($j = 3; $j < count($parames); $j++) {
					if (preg_match("#effet=#s", $parames[$j])) {
						$parames[$j] = str_replace("effet=", "", $parames[$j]);
						$parames[$j] = str_replace(" ", "", $parames[$j]);
						switch ($parames[$j]) {
							case "vertical" 	: $js_params_effet = 'direction: "vertical"'; break;
							case "fondu" 		: $js_params_effet = 'effect: "fade"'; break;
							case "rebond" 		: $js_params_effet = 'slideEasing: "easeOutBounce"'; break;
							default			 	: $js_params_effet = 'direction: "horizontal"'; break;							
						}
					}
					if (preg_match("#item=#s", $parames[$j])) {
						$item[$i] = str_replace("item=", "", $parames[$j]);
						$js_params_item = ", dispItems: ".$item[$i];
					}
					if (preg_match("#pagination=#s", $parames[$j])) {
						$pagination[$i] = str_replace("pagination=", "", $parames[$j]);
						if ($pagination[$i] == 1) $js_params_pag = ", pagination: true";
						else $js_params_pag = "";
					}
					if (preg_match("#diaporama=#s", $parames[$j])) {
						$defil = str_replace("diaporama=", "", $parames[$j]);
						if ($defil == 1) $js_params_diapo .= ", autoSlide: true, autoSlideInterval: ".$delais.", delayAutoSlide: ".$delais;
						else $js_params_diapo = "";
					}		
				}
			}
			$header .= "		$(\"div.kirousel-".$i."_".$alias."\").kirousel(".$js_params_start.$js_params_effet.$js_params_item.$js_params_diapo.$js_params_pag.$js_params.$js_params_end.");
";
	}
		$header .= "	}); /* ]]> */
	</script>
";
	
		// faire tous les carousels de la page
		for($z = 0; $z < count($regs); $z++) {
			
			$parames =  $regs[$z][1];
			$parames = explode(",", $parames);
			$width = $parames[1];
			$height = $parames[2];		

			// MISE EN FORME  _______________________________________________________________________
			// cas général _________________________________________________________
				if(!$_REQUEST['print'] && $_REQUEST['format']!="pdf") {
				
					$folder = $dossier.$parames[0];
					@$dossierb = opendir($folder);
					$images = "";
					$img = "";
					if ($dossierb != FALSE) {
						while ($Fichier = readdir($dossierb))
						{
							if ($Fichier != "." && $Fichier != ".." && (preg_match("#.jpg#", $Fichier) || preg_match("#.gif#", $Fichier) || preg_match("#.png#", $Fichier)))
							{
								$images[] = $Fichier;
							}
						}
						closedir($dossierb);
					}
					if (sizeof($images) > 0 && $dossierb != FALSE) {
						sort($images);
						$i = 0;
						foreach ($images as $a) {
							 if ($i ==0 ) $img .= "\r\n							<li><img style=\"width:".$parames[1]."px;\" src='".$mosConfig_live_site."/".$folder."/".$a."' alt='".$row->title."'  /></li>" ;
							 else $img .= "\r\n							<li><img src='".$mosConfig_live_site."/".$folder."/".$a."' alt='".$row->title."' /></li>" ;
							 $i++;
						}

						$row->text = preg_replace("#\[kirousel](.+?)\[/kirousel]#", "[kirousel]".$img."[/kirousel]", $row->text, 1  );					
					
						if (sizeof($images) > 1) {
								$row->text = preg_replace( "#\[kirousel\]#", '<div class="kirousel_container kirousel_container_'.$z."_".$alias.'">
					<div class="kirousel kirousel-'.$z."_".$alias.' ">
						<ul>', $row->text, 1);
						}
						else {
								$row->text = preg_replace( "#\[kirousel\]#", '<div class="kirousel_container kirousel_container_'.$z."_".$alias.'">
					<div class="kirousel kirousel-'.$z."_".$alias.' ">
						<ul>', $row->text, 1);
							
						}
					
						$row->text = preg_replace( "#\[/kirousel\]#","\r\n						</ul>
				</div>
			</div>", $row->text, 1);
					}
					else $row->text = preg_replace("#\[kirousel](.+?)\[/kirousel]#", "", $row->text, 1  );
			
				}


		// Ajout du CSS & du JS _______________________________________________________________________
				if ($item[$z] > 1) $width_c = $width * $item[$z];
				else $width_c = $width;
				if ($pagination[$z] == 1)	{
					if (sizeof($images) == 1) $none = " display: none; ";
					else $none = "";
					$pagin = "
		.kirousel_container_".$z."_".$alias." .kirousel-pagination { width:".($width_c-56)."px; ".$none." }
		.kirousel_container_".$z."_".$alias." { padding-bottom: 0px!important; }
		";
			}
				else $pagin = "";
				
				$css .= "
		.kirousel_container_".$z."_".$alias." .kirousel.js .kirousel-wrap { height:".$height."px; width:".$width_c."px; }
		.kirousel_container_".$z."_".$alias." .kirousel.js ul li  { height:".$height."px; width:".$width."px; }
		.kirousel_container_".$z."_".$alias." { width:".$width_c."px;  }".$pagin."
		.kirousel_container_".$z."_".$alias." .kirousel .previous { top: ".($height+25)."px;}
		.kirousel_container_".$z."_".$alias." .kirousel .next { top: ".($height+25)."px;}			
	";
/* 		.kirousel_container_".$z." { width:".$width_c."px; height:".$height."px; }".$pagin." */
				
		}

		$css = "	<style type='text/css'>".$css."</style>
";
		$header .= $css;
		$header .= "  <!-- Kinesphère \"Kirousel\" Plugin (v1.0) ends here --> ";

		// cache check
		if($mainframe->getCfg('caching') && ($option=='com_frontpage' || $option=='')) echo $header;
		else $mainframe->addCustomHeadTag($header);
	
	} // fonction

} // class

?>
