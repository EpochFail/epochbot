require "git"
require "fileutils"

class AdminController < Rubot::Controller
  command :reload, :protected => true do
    dispatcher.reload
    reply "reloaded"
  end

  command :quit, :protected => true do
    dispatcher.quit
  end

  command :up do
    reply server.connected_at.time_ago_in_words
  end

  command :raw, :protected => true do
    server.raw message.text
  end

  command :update, :protected => true do
    begin
      repo = Git.open(Dir.pwd)

      # looks like the pull method isn't working properly, so
      # we specify the individual steps instead
      repo.remote.fetch
      reply repo.remote.merge
    rescue Exception => e
      reply e.message
    end
  end

  # todo: whenever rubot is environment aware, this should be
  # automated in production
  command :backup, :protected => true do
    begin
      FileUtils.copy "db/development.db", "Q:/Users/cthorn/rdibot/#{Time.now.strftime('%Y%m%d%I%M%S')}.sqlite"
      reply "done"
    rescue Exception => e
      reply e.message
    end
  end

  on :quit do
    puts "totally caught the quit event!"
  end

  on :connect do
    puts "totally caught the connect event!"
  end
  
  on :reload do
    puts "totally caught the reload event!"
  end
end
