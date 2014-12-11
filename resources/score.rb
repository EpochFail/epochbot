class Score < Sequel::Model
  # this relationship is actually 1:1, but due to how Sequel
  # handles things, we have to use many_to_one here. It's
  # many in this model because the foreign key resides here.
  many_to_one :user

  def update_score(delta)
    self.current += delta
    self.minimum = [minimum, current].min
    self.maximum = [maximum, current].max
  end
end