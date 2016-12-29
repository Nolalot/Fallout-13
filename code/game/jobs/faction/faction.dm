var/human_factions = list()

proc/get_faction_datum(faction)
	if(!human_factions[faction])
		return null

	return human_factions[faction]

/datum/f13_faction
	var/name = "UNKNOWN"

	var/late_join = 0

	var/first_spawn = 0

	var/welcome_text = ""

	var/color = "#ff0000"

	var/actions = list()
mob/proc/set_faction(var/faction)
	var/datum/f13_faction/F = human_factions[faction]
	if(!F)
		return 0
	src.faction = F.name
	src << "Now you are in <span>[F.name]</span>"
	if(F.welcome_text)
		src << F.welcome_text
	return 1

/datum/f13_faction/vault
	name = "Vault"
	first_spawn = 1
	color = "#005A20"
/datum/f13_faction/ncr
	name = "NCR"
	first_spawn = 1
	color = "#020080"
	welcome_text = "Your current objectives:<br>\
1. As an NCR soldier you must uphold the law around town, kill any raiders you see,  find and kill everyone Legion member<br>\
2. As an NCR soldier you must protect the innocent wastelanders from the horrors the wasteland brings<br>\
3. Protect yourself above all others, your important to the NCR and we can't afford to lose you.<br>"
/datum/f13_faction/legion
	name = "Legion"
	first_spawn = 1
	color = "#C24D44"
	welcome_text = "Your current objectives:<br>\
	1. As a member of The Legion you must obey all orders given by anyone out ranking out<br>\
	2. You must enslave the occupants of the wasteland, kill any that resist unless they can be over powered<br>\
	3. As a Legion solider you will kill any NCR you come across, fight to your death for Caesar!!"
/datum/f13_faction/wasteland
	name = "Wasteland"
	late_join = 1
/datum/f13_faction/den
	name = "Den"
	first_spawn = 1