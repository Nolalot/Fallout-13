//Fallout 13 - Loadsamoney

var/datum/subsystem/content/SScontent



/datum/subsystem/content
	name = "Content"
	init_order = 0
	priority = 0

	var/system_state = -1

	var/list/all_content_packs = list()

	wait = 6000

/datum/subsystem/content/New()
	NEW_SS_GLOBAL(SScontent)

/datum/subsystem/content/Initialize(timeofday)
	system_state = check_connection()
	load_content_packs()
	update_all_data()

/datum/subsystem/content/fire(resumed = 0)
	system_state = check_connection()

/datum/subsystem/content/stat_entry()
	..("[system_state]")

/datum/subsystem/content/proc/update_all_data()
	for(var/client/C)
		C.update_content_data()

/datum/subsystem/content/proc/get_pack(id)
	return all_content_packs[id]

/datum/subsystem/content/proc/get_data(ckey)
	if(curl.Http(ADDRESS_DONATE_DATA, list("ckey" = "[ckey(ckey)]", "action" = "full"), "temp"))
		return file2text("temp")
	return "0:"

/datum/subsystem/content/proc/buy_pack(ckey, pack_id, price)
	if(curl.Http(ADDRESS_DONATE_DATA, list("ckey" = "[ckey(ckey)]", "pack" = "[pack_id]", "price" = "[price]", "action" = "buy"), "temp"))
		var/result = file2text("temp")
		if(result == "SUCCESS")
			return 1
	return 0

/datum/subsystem/content/proc/check_connection()
	if(curl.Http(ADDRESS_DONATE_DATA, list("action" = "check"), "temp"))
		var/data = file2text("temp")
		if(data == "OK")
			return "Work"
		else
			return "Error: " + data
	return "Can't connect"

/datum/subsystem/content/proc/load_content_packs()
	var/list/all_packs = subtypesof(/datum/content_pack)
	if(!all_packs.len)
		to_chat(world, "<span class='boldannounce'>Error setting up jobs, no content packs datums found!</span>")
		return 0
	for(var/type in all_packs)
		var/datum/content_pack/D = new type()
		all_content_packs[D.id] = D