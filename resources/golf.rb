class GolfPlayer < Sequel::Model
  def playing?
    !!playing
  end

  def played_round?
    !!played_round
  end
end