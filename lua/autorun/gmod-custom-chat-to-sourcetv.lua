-- xproot's code
-- this should send all messages from CustomChat (that generate a PostPlayerSay to SourceTV.
-- Temporary fix before https://github.com/StyledStrike/gmod-custom-chat/issues/57 gets fixed.

if SERVER then
	local function PostPlayerSay(speaker, text, teamOnly, channel, dmTarget)
		for _, ply in ipairs( player.GetBots() ) do
			if ply:GetPlayerInfo().ishltv then
				net.Start( "customchat.say", false )
				net.WriteString( util.TableToJSON( {
					channel = channel,
					text = text
				} ) )
				net.WriteEntity( speaker )
				net.Send( ply )
				-- print("DEBUG: Message sent to SourceTV")
			end
		end
	end

	hook.Add("PostPlayerSay", "gmod_custom_chat_to_sourcetv", PostPlayerSay)
end