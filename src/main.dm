var/list/config = json_decode(file2text("config.json"))


var/target = "byond://"


/world
  hub = "Exadv1.spacestation13"


/world/New()
  ..()
  world.name = config["name"]
  if (!config["host"] || config["host"] == "auto")
    target += world.internet_address
  else
    target += config["host"]
  target += ":[config["port"]]"
  world.log << target
  if (!config["hide"])
    hub_password = "kMZy3U5jJHSiBQjr"


/client/New()

  // ip safety checks etc
  ..()


/client/var/code


/mob/Login()
  client.code = copytext(sha1("[rand()]"), 1, 9)
  src << browse_rsc('src/page.html', "page.html")
  src << browse('src/page.html', "main.view")


/client/Topic(href, list/params)
  if (params["code"])
    src << output(code, "main.view:setCode")
    return
  if (params["entry"] == code)
    world.Export("[target]?allow=[ckey]")
    sleep(10)
    src << link(target)
    return
