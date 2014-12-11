class PointsController < BaseController
  command :points do
    if message.text.empty?
      reply User.where("score <> 0").order(:score.desc).map { |u| format_score(u) }.join(" | ")
    else
      words = message.text.split
      user = User.from_nick words.first

      if words.count > 1
        if current_user.nick == user.nick
          reply "#{message.from}: you cannot modify your own score"
        else
          amount = words[1].to_i

          if current_user.score - amount.abs < 0
            reply "Balance too low (#{current_user.score})"
          else
            PointTransaction.create({
              :amount => amount,
              :sender => current_user,
              :receiver => user,
              :reason => words[2..-1].join(" ")
            })

            reply "#{format_score(user)} #{format_score(current_user)}"
          end
        end
      else
        reply format_score(user)
      end
    end
  end

  def format_score(user)
    "#{user.nick}: #{user.score}"
  end
end
