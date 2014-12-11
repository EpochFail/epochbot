Sequel.migration do
  change do
    create_table :links do
      primary_key :id
      string :url
      time :post_time
      int :user_id
    end
  end
end
