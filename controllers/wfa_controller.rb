class WfaController < Rubot::Controller
	command :wfa do
		reply Wfa.search(:input => message.text, :appid => '8HVPUR-RX2A9985XP')
	end
end