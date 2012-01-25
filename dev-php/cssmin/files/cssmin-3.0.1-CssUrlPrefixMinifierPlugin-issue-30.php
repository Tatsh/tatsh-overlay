<?php

class CssUrlPrefixMinifierPlugin extends aCssMinifierPlugin {

	/**
	 * Regular expression matching the value.
	 * 
	 * @var string
	 */
	private $reMatch = "/^url\s*\(\s*([^\)]+)\)/iS";

	/**
	 * Implements {@link aCssMinifierPlugin::minify()}.
	 * 
	 * @param aCssToken $token Token to process
	 * @return boolean Return TRUE to break the processing of this token; FALSE to continue
	 */
	public function apply(aCssToken &$token) {
		if (get_class($token) === "CssRulesetDeclarationToken" && stripos($token->Value, "url") !== false && preg_match($this->reMatch, $token->Value, $m)) {
			$token->Value = str_replace($m[1], $this->urlPrefix($m[1]), $token->Value);
		}
		return false;
	}
	
	/**
	 * Implements {@link aMinifierPlugin::getTriggerTokens()}
	 * 
	 * @return array
	 */
	public function getTriggerTokens()
	{
		return array(
			"CssRulesetDeclarationToken"
		);
	}

	private function urlPrefix($url) {
		$url = str_replace('"', "", $url);
		return $this->resolveHref($this->configuration["BaseUrl"], $url);
	}
	
	function resolveHref($base, $href) {

		// href="" ==> current url.
		if (!$href) {
			return $base;
		}

		// href="http://..." ==> href isn't relative
		$rel_parsed = parse_url($href);
		if (array_key_exists('scheme', $rel_parsed)) {
			return $href;
		}

		// add an extra character so that, if it ends in a /, we don't lose the last piece.
		$base_parsed = parse_url("$base ");
		// if it's just server.com and no path, then put a / there.
		if (!array_key_exists('path', $base_parsed)) {
			$base_parsed = parse_url("$base/ ");
		}

		// href="/ ==> throw away current path.
		if ($href{0} === "/") {
			$path = $href;
		} else {
			$path = dirname($base_parsed['path']) . "/$href";
		}

		// bla/./bloo ==> bla/bloo
		$path = preg_replace('~/\./~', '/', $path);

		// resolve /../
		// loop through all the parts, popping whenever there's a .., pushing otherwise.
		$parts = array();
		foreach (
		explode('/', preg_replace('~/+~', '/', $path)) as $part
		)
			if ($part === "..") {
				array_pop($parts);
			} elseif ($part != "") {
				$parts[] = $part;
			}

		return (
		(array_key_exists('scheme', $base_parsed)) ?
				$base_parsed['scheme'] . '://' . $base_parsed['host'] : ""
		) . "/" . implode("/", $parts);
	}
}

?>
