/datum/spawners_menu
	var/mob/dead/observer/owner

/datum/spawners_menu/New(mob/dead/observer/new_owner)
	if(!istype(new_owner))
		qdel(src)
	owner = new_owner

/datum/spawners_menu/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = FALSE, datum/nanoui/master_ui = null)
	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "spawners_menu.tmpl", "Spawners Menu", 700, 600, master_ui)
		ui.open()

/datum/spawners_menu/ui_data(mob/user)
	var/list/data = list()
	data["spawners"] = list()
	for(var/spawner in GLOB.mob_spawners)
		var/list/this = list()
		this["name"] = spawner
		this["desc"] = ""
		this["refs"] = list()
		for(var/spawner_obj in GLOB.mob_spawners[spawner])
			this["refs"] += "[UID(spawner_obj)]"
			if(!this["desc"])
				if(istype(spawner_obj, /obj/effect/mob_spawn))
					var/obj/effect/mob_spawn/MS = spawner_obj
					this["desc"] = MS.flavour_text
				else
					var/obj/O = spawner_obj
					this["desc"] = O.desc
		this["amount_left"] = LAZYLEN(GLOB.mob_spawners[spawner])
		data["spawners"] += list(this)

	return data

/datum/spawners_menu/Topic(href, href_list)
	to_chat(src,"FUCKKK")
	if(..())
		return
	to_chat(src, GLOB.mob_spawners.len)
	var/spawner_ref = pick(GLOB.mob_spawners[href_list["name"]])
	var/obj/effect/mob_spawn/MS = locate(spawner_ref) in GLOB.poi_list
	if(!MS)
		to_chat(src,"wank")
		return
	to_chat(src,"FUCweweKKK")
	switch(href_list)
		if("jump")
			if(MS)
				owner.forceMove(get_turf(MS))
				. = TRUE
		if("spawn")
			if(MS)
				MS.attack_ghost(owner)
				. = TRUE
	to_chat(src,"FUzxcCKKK")
