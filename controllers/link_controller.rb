class LinkController < BaseController
  listener :matches => %r{https?://[^\s]+} do
    current_user.add_link Link.create :url => matches.to_s, :post_time => Time.now
  end

  command :link, :links do
    if message.text.empty?
      reply format_hash(top_linkers)
    elsif respond_to? "reply_#{args.first}"
      send "reply_#{args.first}"
    else
      reply_nick
    end
  end

  def args
    @args ||= message.text.split
  end

  def reply_nick
    if user = find_user(args.first)
      count = user.links.count
      reply "#{user.nick}: #{count} links"
    else
      reply "unrecognized: #{args.first}"
    end
  end

  def reply_domain
    limit = args[1].to_i if args[1]
    reply format_hash(top_domains(limit))
  end

  alias_method :reply_domains, :reply_domain
  alias_method :reply_host, :reply_domain
  alias_method :reply_hosts, :reply_domain

  def find_user(nick)
    User.from_nick nick, :create => false
  end

  def top_linkers
    counts = Link.group_and_count(:user_id).order(:count.desc)
    data = counts.map do |link|
      [User[link.user_id].nick, link[:count]]
    end
    Hash[data]
  end

  def top_domains(limit = nil)
    limit ||= 10
    counts = Link.group_and_count(:host).order(:count.desc).limit(limit)
    Hash[counts.map { |h| [h[:host], h[:count]] }]
  end

  def format_hash(linkers)
    linkers.map { |n, c| "#{n}: #{c}" }.join(" | ")
  end
end
