Sequel.migration do
  up do
    DB.transaction do
      DB[:point_events].delete
      DB[:scores].delete
      DB[:users].delete
    end
  end

  # there is no down. only option here is to restore a backup
  down do
  end
end
