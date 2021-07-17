/*
    This Yara ruleset is under the GNU-GPLv2 license (http://www.gnu.org/licenses/gpl-2.0.html) and open to any user or organization, as
    long as you use it under this license.
*/

rule scam : mail {
	meta:
		author = "R.Hackson <rhackson@uruscg.com>"
		description = "Detects scam emails with ."
	strings:
		$body = "million" nocase
	condition:
		$body
}
