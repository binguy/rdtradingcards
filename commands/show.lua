local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !show")
  if #mt == 1 then
    local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
    local request = mt[1]
    print(request)
    local curfilename = texttofn(request)
    
    print(curfilename)
    if curfilename ~= nil then
      if uj.inventory[curfilename] or uj.storage[curfilename] then
        print("user has card")
        if not getcardspoiler(curfilename) then
          local embeddescription = ""
          if getcarddescription(curfilename) then
            embeddescription = "\n\n*The description on the back reads:*\n> " .. getcarddescription(curfilename)
          end
          -- message.channel:send('Here it is! Your **'.. fntoname(curfilename) .. '** card. The shorthand form is **' .. curfilename .. '**.')
          -- message.channel:send('https://cdn.discordapp.com/attachments/' .. attachmentchannel .. '/' .. getcardembed(curfilename) .. '/' .. curfilename .. extension)
          message.channel:send{embed = {
            color = 0x85c5ff,
            title = "Showing card...",
            description = 
            'Here it is! Your **'.. fntoname(curfilename) .. '** card. The shorthand form is **' .. curfilename .. '**.' .. embeddescription,
            image = {
              url = getcardembed(curfilename)
            }
          }}
        else
          print("spiderrrrrrr")
          message.channel:send{
            content = 'Here it is! Your **'.. fntoname(curfilename) .. '** card. The shorthand form is **' .. curfilename .. '**.',
            file = "card_images/SPOILER_" .. curfilename .. ".png"
          }
          if getcarddescription(curfilename) then
            message.channel:send("The description on the back reads:\n> " .. getcarddescription(curfilename))
          end
        end
      else
        print("user doesnt have card")
        if nopeeking then
          message.channel:send("Sorry, but I either could not find the " .. request .. " card in the database, or you do not have it. Make sure that you spelled it right!")
        else
          message.channel:send("Sorry, but you don't have the **" .. fntoname(curfilename) .. "** card in your inventory or your storage.")
        end
      end
    else
      if nopeeking then
        message.channel:send("Sorry, but I either could not find the " .. request .. " card in the database, or you do not have it. Make sure that you spelled it right!")
      else
        message.channel:send("Sorry, but I could not find the " .. request .. " card in the database. Make sure that you spelled it right!")
      end
    end
  
  -- whole lotta code to display a png image lmao
  else
    message.channel:send("Sorry, but the c!show command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  