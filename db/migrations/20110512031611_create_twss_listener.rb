Sequel.migration do
  change do
    create_table :twss_listener do
      primary_key :id
      string :word
      integer :count
    end
  end
end
