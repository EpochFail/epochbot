class Link < Sequel::Model
  many_to_one :user

  def before_create
    self.host = uri.host unless host
  end

  def uri
    @uri ||= URI(URI.escape(url))
  end
end
