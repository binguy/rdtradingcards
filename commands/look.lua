local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !look")
  if #mt == 1 or mt[1] == "" then
    if string.lower(mt[1]) == "pyrowmid" then
      message.channel:send('The **Pyrowmid** has recently opened itself, revealing a **Panda** and a **Strange Machine** inside. The walls are made of Rows (Rare) cards.')
      message.channel:send('https://cdn.discordapp.com/attachments/829197797789532181/829255814169493535/pyr7.png')
    elseif string.lower(mt[1]) == "panda" or string.lower(mt[1]) == "het" then 
      message.channel:send {
        content = 'The **Panda** looks confused, and probably would rather not be here in the **Pyrowmid**. That **Throne** he is sitting on sure does look comfortable, though.'
      }
    elseif string.lower(mt[1]) == "throne" then 
      message.channel:send {
        content = 'The **Throne**, like the walls of the **Pyrowmid** are made of Rows (Rare) cards. It is unknown how it is being held together.'
      }
    elseif string.lower(mt[1]) == "strange machine" or string.lower(mt[1]) == "machine" then 
      message.channel:send {
        content = 'The **Strange Machine** appears to have a slot for two **Tokens**, and a crank. The crank is worn, as if it has been **Used** many times.'
      }
    elseif string.lower(mt[1]) == "card factory" or string.lower(mt[1]) == "factory" or string.lower(mt[1]) == "cardfactory" or string.lower(mt[1]) == "the card factory" then 
      message.channel:send {
        content = ':eye:`the card factory looks back`:eye:'
      }
    elseif string.lower(mt[1]) == "token"  then 
      message.channel:send('You do not know how, but lots of these **Tokens** have been showing up recently. If only there were somewhere to **Use** them...')
      message.channel:send('https://cdn.discordapp.com/attachments/829197797789532181/829255830485598258/token.png')
--    elseif string.lower(mt[1]) == "lab" or string.lower(mt[1]) == "abandoned lab" then 
--      message.channel:send {
--        content = ':eye:`the card factory looks back`:eye:'
--      }




    else
      message.channel:send("Sorry, but I cannot find " .. mt[1] .. ".")
    end




  else
    message.channel:send("Sorry, but the c!look command expects 1 argument. Please see c!help for more details.")
  end
end
return command
  