require "json"

class User < Sequel::Model
  one_to_many :point_events
  one_to_many :sent_transactions, :class => :PointTransaction, :key => :sender_id
  one_to_many :received_transactions, :class => :PointTransaction, :key => :receiver_id
  one_to_many :links

  # Case insensitive search for user by nick. If a user does not
  # exist, one will be created.
  def self.from_nick(nick, options = {})
    default_options = {
      :create => true
    }

    options = default_options.merge(options)

    # drop trailing crap. don't modify the incoming value
    nick = nick.gsub(/[-_\d]+$/, "")

    user = find { { lower(:nick) => nick.downcase } }
    if user.nil? && options[:create]
      user = User.create :nick => nick
    end
    user
  end
end
