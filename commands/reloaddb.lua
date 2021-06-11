local command = {}
function command.run(message, mt,overwrite)
  if overwrite then
    authcheck = true
  else
    
    local cmember = message.guild:getMember(message.author)
    authcheck = cmember:hasRole(privatestuff.modroleid)
  end
  if authcheck then
    print("authcheck passed")
    _G["privatestuff"] = dofile('privatestuff.lua')
    cmd.ping = dofile('commands/ping.lua')
    cmd.help = dofile('commands/help.lua')
    cmd.resetclock = dofile('commands/resetclock.lua')
    cmd.uptime = dofile('commands/uptime.lua')
    cmd.testcards = dofile('commands/testcards.lua')
    cmd.pull = dofile('commands/pull.lua')
    cmd.inventory = dofile('commands/inventory.lua')
    cmd.show = dofile('commands/show.lua')
    cmd.give = dofile('commands/give.lua')
    cmd.trade = dofile('commands/trade.lua')
    cmd.store = dofile('commands/store.lua')
    cmd.storage = dofile('commands/storage.lua')
    cmd.checkcollectors = dofile('commands/checkcollectors.lua')
    cmd.checkmedals = dofile('commands/checkmedals.lua')
    cmd.reloaddb = dofile('commands/reloaddb.lua')
    cmd.medals = dofile('commands/medals.lua')
    cmd.crash = dofile('commands/crash.lua')
    cmd.showmedal = dofile('commands/showmedal.lua')
    cmd.runlua = dofile('commands/runlua.lua')
    cmd.generategive = dofile('commands/generategive.lua')
    cmd.search = dofile('commands/search.lua')
    cmd.tell = dofile('commands/tell.lua')
    cmd.tellimage = dofile('commands/tellimage.lua')
    cmd.beans = dofile('commands/beans.lua')
    cmd.nickname = dofile('commands/nickname.lua')
    cmd.pray = dofile('commands/pray.lua')
    cmd.smell = dofile('commands/smell.lua')
    cmd.shred = dofile('commands/shred.lua')
    cmd.look = dofile('commands/look.lua')
    cmd.use = dofile('commands/use.lua')
    cmd.items = dofile('commands/items.lua')
    cmd.showitem = dofile('commands/showitem.lua')
    cmd.equip = dofile('commands/equip.lua')
    cmd.yeetalltokens = dofile('commands/yeetalltokens.lua')
    cmd.survey = dofile('commands/survey.lua')
    cmd.granttoken = dofile('commands/granttoken.lua')
    cmd.addallnicknames = dofile('commands/addallnicknames.lua')
    cmd.fullinventory = dofile('commands/fullinventory.lua')
    cmd.fullstorage = dofile('commands/fullstorage.lua')
    cmd.setworldstate = dofile('commands/setworldstate.lua')
    cmd.givetoken = dofile('commands/givetoken.lua')
    cmd.skipprompts = dofile('commands/skipprompts.lua')
    cmd.renamefile = dofile('commands/renamefile.lua')
    cmd.addallpronoun = dofile('commands/addallpronoun.lua')
    cmd.pronoun = dofile('commands/pronoun.lua')
    cmd.pronounlist = dofile('commands/pronounlist.lua')
    cmd.pronounform = dofile('commands/pronounform.lua')
    cmd.getfile = dofile('commands/getfile.lua')
    
    print("done loading commands")

    -- import reaction commands
    cmdre = {}
    cmdre.trade = dofile('reactions/trade.lua')
    cmdre.store = dofile('reactions/store.lua')
    cmdre.shred = dofile('reactions/shred.lua')
    cmdre.equip = dofile('reactions/equip.lua')
    cmdre.usemachine = dofile('reactions/usemachine.lua')
    cmdre.usehole = dofile('reactions/usehole.lua')
    cmdre.spideruse = dofile('reactions/spideruse.lua')
    cmdre.spiderlook = dofile('reactions/spiderlook.lua')
    cmdre.spidersmell = dofile('reactions/spidersmell.lua')
    cmdre.getladder = dofile('reactions/getladder.lua')
    cmdre.usemousehole = dofile('reactions/usemousehole.lua')
    cmdre.usebox = dofile('reactions/usebox.lua')
    
    print("done loading reactions")

    _G['defaultjson'] = {inventory={},storage={},medals={},items={nothing=true},lastpull=-24,lastprayer=-7,lastequip=-24,lastbox=-24,tokens=0,pronouns={their="their",them="them",theirself="themself",they="they",theirs="theirs"}}
    
    _G['defaultworldsave'] = {tokensdonated=0,boxpool={"ssss45","roomsdc_ur","roomsdc_r","underworld","enchantedlove","wallclockur","rhythmdogtor","moai","coolbird","beanshopper","cardboardworld","acofoi","rollermobster","inimaur","fhottour","superstrongcavity","soundsr","pancakefever","nicoleur","feedthemachine","retrofunky","heartchickalt"},lablookindex=0,lablooktext="password is gnuthca ",worldstate = "prehole"}

    _G['debug'] = false
    
    _G["attachmentchannel"] = "829197797789532181"
    print("loading cards")
    cj =  io.open("data/cards.json", "r")
    
    print('loading itemdb')    
    _G['itemdb'] = dpf.loadjson("data/items.json",defaultjson)
    print("loading cards part 2: electric boogaloo")

    _G['cdata'] = json.decode(cj:read("*a"))
    cj:close()

    --generate pull table
    _G['ptable'] = {}
    _G['seasontable'] = {}
    _G['cdb'] = {}
    for k,q in pairs(itemdb) do
      ptable[k] = {}
      for i,v in ipairs(cdata.groups) do
        for w,x in ipairs(v.cards) do
          local cmult = 1
          if x.bonuses[k] then
            cmult = 10 -- might tweak this??
          end
          for y=1,(cdata.basemult*v.basechance*x.chance*cmult) do
            table.insert(ptable[k],x.filename)
          end
        end
      end
    end
    for i,v in ipairs(cdata.groups) do
      for w,x in ipairs(v.cards) do
        table.insert(cdb,x)
        if seasontable[x.season] == nil then
			seasontable[x.season] = {}
        end
        table.insert(seasontable[x.season],x.filename)
        print(x.name.. " loaded!")
      end
    end
    --dpf.savejson("savedata/pulltable.json",ptable)
    
    print("here is cdb")
    print(inspect(cdb))
    print("here is seasontable")
    print(inspect(seasontable))
    -- print("here is ptable")
    --print(inspect(ptable))

    print("loading collector's info")
    _G['coll'] = dpf.loadjson("data/coll.json",defaultjson)
    print("loading medaldb")
    _G['medaldb'] = dpf.loadjson("data/medals.json",defaultjson)
    print('loading itemdb')    
    _G['itemdb'] = dpf.loadjson("data/items.json",defaultjson)
    
    print("generating item pull table")
    _G['itempt'] = {}
    for k,v in pairs(itemdb) do
      if k ~= "fixedmouse" then
        table.insert(itempt,k)
      end
    end
    print(inspect(itempt))
    
    print("loading medal requires")
    _G['medalrequires'] = dpf.loadjson("data/medalrequires.json",defaultjson)
    
    
    _G['labimages'] = {
      "https://cdn.discordapp.com/attachments/829197797789532181/831907762081497118/lab0.png", --use embeds, they said
      "https://cdn.discordapp.com/attachments/829197797789532181/831907763076333588/lab1.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907764762574868/lab2.png", --it will be easy, they said
      "https://cdn.discordapp.com/attachments/829197797789532181/831907766682517544/lab3.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907771020214292/lab4.png", --i'm so sorry, dps
      "https://cdn.discordapp.com/attachments/829197797789532181/831907771716075632/lab5.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907773830791198/lab6.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907776657227816/lab7.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907779236724786/lab8.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907782151110656/lab9.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907809926316052/lab10.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907816570224700/lab11.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907820299485215/lab12.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907824485400626/lab13.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907829383823401/lab14.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907832977948712/lab15.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907838213357638/lab16.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907842084175872/lab17.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907846848380958/lab18.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907851671830538/lab19.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907856558194708/lab20.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907860207239168/lab21.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907864444534834/lab22.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907869049356338/lab23.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907874141765683/lab24.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907878990381076/lab25.png",
      "https://cdn.discordapp.com/attachments/829197797789532181/831907882618323015/lab26.png" --h      
    }
    _G['letters'] = {
      " ",
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "z"
    }
    
    
    print("loading functions")
    
    _G['getletterindex'] = function (x)
      print("finding letterindex of "..x)
      for i,v in ipairs(letters) do
        if v == x then
          return i
        end
      end
      
    end
    
    
    _G['fntoname'] = function (x)
      print("finding "..x)
      for i,v in ipairs(cdb) do
        if string.lower(v.filename) == string.lower(x) then
          local match = v.name
          print(x.." = "..v.name)
          return v.name
        end
      end
      
    end

    _G['nametofn'] = function (x)
      for i,v in ipairs(cdb) do
        if string.lower(v.name) == string.lower(x) then
          local match = v.filename
          return v.filename
        end
      end
    end

    _G['resetclocks'] = function ()
      for i,v in ipairs(scandir("savedata")) do
        cuj = dpf.loadjson("savedata/"..v,defaultjson)
        if cuj.lastpull then
          cuj.lastpull = -24
          cuj.lastprayer = -24
          cuj.lastequip = -24
          cuj.lastbox = -24
        end
        dpf.savejson("savedata/"..v,cuj)
      end
    end
    --really cool and good code goes here
    --variable = "string" .. nilvalue

    _G['texttofn'] = function (x)
      local cfn = nametofn(x)
      if cfn == nil then
        cfn = fntoname(x)
        if cfn ~= nil then
          cfn = string.lower(x)
        end
      end
      return cfn
    end
    _G['medalnametofn'] = function (x)
      for k,v in pairs(medaldb) do
        if string.lower(v.name) == string.lower(x) then
          local match = k
          return k
        end
      end
    end
    _G['medalfntoname'] = function (x)
      print("finding "..x)
      for k,v in pairs(medaldb) do
        if string.lower(k) == string.lower(x) then
          local match = v.name
          print(x.." = "..v.name)
          return v.name
        end
      end
      
    end

    _G['medaltexttofn'] = function (x)
      local cfn = medalnametofn(x)
      if cfn == nil then
        cfn = medalfntoname(x)
        if cfn ~= nil then
          cfn = string.lower(x)
        end
      end
      return cfn
    end
    
    ---aaaaaa
    _G['itemnametofn'] = function (x)
      for k,v in pairs(itemdb) do
        if string.lower(v.name) == string.lower(x) then
          local match = k
          return k
        end
      end
    end
    _G['itemfntoname'] = function (x)
      print("finding "..x)
      for k,v in pairs(itemdb) do
        if string.lower(k) == string.lower(x) then
          local match = v.name
          print(x.." = "..v.name)
          return v.name
        end
      end
      
    end

    _G['itemtexttofn'] = function (x)
      local cfn = itemnametofn(x)
      if cfn == nil then
        cfn = itemfntoname(x)
        if cfn ~= nil then
          cfn = string.lower(x)
        end
      end
      if cfn ~= nil then
        print("itemtext returning " .. cfn)
      else
        print("wow, its nil")
      end
      return cfn
    end
    
    _G['getcardtype'] = function (x)
      local ctype = nil
      for i,v in ipairs(cdb) do
        
        if v.filename == x then
          print(v.filename)
          ctype = v.type
        end
      end
      return ctype
    end
    
    
    
    
    --- end aaaa
    _G['getcarddescription'] = function (x)
      print("getting description for " .. x)
      local cdescription = nil
      for i,v in ipairs(cdb) do
        
        if v.filename == x then
          print(v.description)
          cdescription = v.description
        end
      end
      return cdescription
    end
    
	
    _G['getcardsmell'] = function (x)
      print("getting smell for " .. x)
      local csmell = nil
      for i,v in ipairs(cdb) do
        
        if v.filename == x then
          print(v.smell)
          csmell = v.smell
        end
      end
      return csmell 
    end

    _G['getcardembed'] = function (x)
      local cembed = nil
      for i,v in ipairs(cdb) do
        
        if v.filename == x then
          cembed = v.embed
          print(v.smell)
          if v.randomized then
            if math.random(0,1) == 0 then
              cembed = v.embedalt
            end
          end
          
        end
      end
      return cembed
    end
    
    _G['getcardspoiler'] = function (x)
      print("getting spoiler for " .. x)
      local cspoiler = nil
      for i,v in ipairs(cdb) do
       
        if v.filename == x then
          print(v.spoiler)
          cspoiler = v.spoiler
          if cspoiler == nil then
            cspoiler = false
          end
        end
      end
      print("returning " .. tostring(cspoiler))
      return cspoiler
    end
    
  
	
    
    -- _G['getcardanimated'] = function (x)
    --   print("getting animated for " .. x)
    --   local canimated = nil
    --   for i,v in ipairs(cdb) do
        
    --     if v.filename == x then
    --       print(v.animated)
    --       canimated = v.animated
    --       if canimated == nil then
    --         canimated = false
    --       end
    --     end
    --   end
  
    --   print("returning" .. tostring(canimated))
    --   return canimated
    -- end
    -- _G['getcardpico'] = function (x)
    --   print("getting pico for " .. x)
    --   local cpico = nil
    --   for i,v in ipairs(cdb) do
        
    --     if v.filename == x then
    --       print(v.pico)
    --       cpico = v.pico
    --       if cpico == nil then
    --         cpico = false
    --       end
    --     end
    --   end
    --   print("returning" .. tostring(cpico))
    --   return cpico
    -- end


    -- Lua implementation of PHP scandir function
    _G['scandir'] = function (directory)
      return fs.readdirSync(directory)
    end

    _G['usernametojson'] = function (x)
      print(x)
      for i,v in ipairs(scandir("savedata")) do
        cuj = dpf.loadjson("savedata/"..v,defaultjson)
        if cuj.id then
          if cuj.id == x or ("<@!" .. cuj.id .. ">") == x or ("<@" .. cuj.id .. ">") == x then --prioritize id and mentions over nickname
            return "savedata/"..v
          end
        end
        if cuj.names then
          for j,w in pairs(cuj.names) do
            if j == x then
              return "savedata/"..v
            end
          end
        end
      end
    end

    _G['addreacts'] = function (x)
      x:addReaction("✅")
      x:addReaction("❌")
    end
    
    
    _G['commands'] = {}
    
    _G['addcommand'] = function(trigger,commandfunction, expectedargs,force)
      local newcommand = {}
      newcommand.trigger = prefix .. trigger
      newcommand.commandfunction = commandfunction or cmd.ping
      newcommand.expectedargs = 0 or expectedargs
      newcommand.force = force
      
      table.insert(commands,newcommand)
      
    end
    
    addcommand("ping",cmd.ping)
    addcommand("help",cmd.help)
    addcommand("resetclock",cmd.resetclock)
    addcommand("uptime",cmd.uptime)
    addcommand("testcards",cmd.testcards)
    addcommand("pull",cmd.pull)
    addcommand("inventory",cmd.inventory)
    addcommand("inv",cmd.inventory)
    
    addcommand("give",cmd.give)
    addcommand("trade",cmd.trade)
    addcommand("store",cmd.store)
    addcommand("storage",cmd.storage)
    addcommand("reloaddb",cmd.reloaddb)
    addcommand("medals",cmd.medals)
    addcommand("crash",cmd.crash)
    addcommand("yeetalltokens",cmd.yeetalltokens)
    addcommand("showmedal",cmd.showmedal)
    addcommand("runlua",cmd.runlua)
    addcommand("generategive",cmd.generategive)  
    addcommand("search",cmd.search)  
    addcommand("tell",cmd.tell)  
    addcommand("tellimage",cmd.tellimage)
    addcommand("beans",cmd.beans)
    addcommand("nickname",cmd.nickname)
    addcommand("pronouns",cmd.pronoun)
    addcommand("pronoun",cmd.pronoun)
    addcommand("pronounlist",cmd.pronounlist)
    addcommand("pronounform",cmd.pronounform)
    addcommand("pray",cmd.pray)
    addcommand("look",cmd.look)
    addcommand("use",cmd.use)
    addcommand("smell",cmd.smell)
    addcommand("shred",cmd.shred)
    addcommand("items",cmd.items)
    addcommand("showitem",cmd.showitem)
    addcommand("equip",cmd.equip)
    addcommand("survey",cmd.survey)
    addcommand("granttoken",cmd.granttoken)
    addcommand("machine",cmd.use,0,{"machine"})
    addcommand("name",cmd.nickname)
    addcommand("addallnicknames",cmd.addallnicknames)
    addcommand("addallpronoun",cmd.addallpronoun)
    addcommand("fullinventory",cmd.fullinventory)
    addcommand("fullinv",cmd.fullinventory)
    addcommand("fullstorage",cmd.fullstorage)
    addcommand("setworldstate",cmd.setworldstate)
    addcommand("ladder",cmd.use,0,{"ladder"})
    addcommand("givetoken",cmd.givetoken)
    addcommand("skipprompts",cmd.skipprompts)
    addcommand("renamefile",cmd.renamefile)
    addcommand("getfile",cmd.getfile)
    addcommand("stats",cmd.use,0,{"terminal","stats"})
    addcommand("upgrade",cmd.use,0,{"terminal","upgrade"})
    addcommand("credits",cmd.use,0,{"terminal","credits"})
    addcommand("savedata",cmd.use,0,{"terminal","savedata"})
    addcommand("terminal",cmd.use,0,{"terminal"})
    addcommand("box",cmd.use,0,{"box"})
    addcommand("show",cmd.show)
    addcommand("p",cmd.pull)
    _G['handlemessage'] = function (message)
      if message.author.id ~= "767445265871142933" then
        local hasrun = false
        for i,v in ipairs(commands) do
          if string.lower(string.sub(message.content, 0, #v.trigger)) == v.trigger and not hasrun then
            print("found ".. v.trigger)
            local mt = {}
            local nmt = {}
            if v.expectedargs == 0 then
              mt = string.split(string.sub(message.content, #v.trigger+1),"/")
              for a,b in ipairs(mt) do
                b = trim(b)
                nmt[a]=b
              end
            elseif v.expectedargs == 1 then
              
              nmt = {trim(string.sub(message.content, #v.trigger+1))}
            end --might have to expand later?
            if v.force then
              for c,d in ipairs(v.force) do
                table.insert(nmt,c,d)
              end
            end
            print("nmt: " .. inspect(nmt))
            hasrun = true
            local status, err = pcall(function ()
              v.commandfunction.run(message,nmt)
            end)
            if not status then
              print("uh oh")
              message.channel:send("Oops! An error has occured! Error message: ```" .. err .. "``` (<@290582109750427648> <@298722923626364928> please fix this thanks)")
            end
              
          end
          
          
        end
        
      end
    
    
    
    end
    print("handlereaction")
    _G['handlereaction'] = function (reaction, userid)
      
      if userid ~= "767445265871142933" then
        local ef = dpf.loadjson("savedata/events.json",{})
        print('a reaction with an emoji named '.. reaction.emojiName .. ' was added to a message with the id of ' .. reaction.message.id ..' by a user with the id of' .. userid)
        eom = ef[reaction.message.id]
        if eom then
          print('it is an event message being reacted to')
          local status, err = pcall(function ()
            cmdre[eom.etype].run(ef, eom, reaction, userid)
          end)
          if not status then
            print("uh oh")
            reaction.message.channel:send("Oops! An error has occured! Error message: ```" .. err .. "``` (<@290582109750427648> <@298722923626364928> please fix this thanks)")
          end
        end
      end
    end
    print("done loading")
    
    if not overwrite then
      message.channel:send('All commands have been reloaded.')
    end
    

  else
    
    message.channel:send('Sorry, but only moderators can use this command!')
  end
  --print(message.author.name .. " did !reloaddb")
end
return command
  
