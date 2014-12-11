class PointTransaction < Sequel::Model
  many_to_one :sender, :class => :User
  many_to_one :receiver, :class => :User
  plugin :serialization, :json, :data
  plugin :validation_helpers

  # pull to a base model
  def validate
    super
    validates_presence :sender unless generated?
    validates_presence [:receiver, :amount]
  end

  def after_create
    receiver.score += amount
    receiver.save

    # subtract the abs value from the sender, unless this
    # was a generated transaction, ie from winning a game.
    unless generated
      sender.score -= amount.abs
      sender.save
    end
  end

  def generated?
    generated
  end
end