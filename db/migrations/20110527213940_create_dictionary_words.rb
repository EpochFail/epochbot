Sequel.migration do
  change do
    create_table :dictionary_words do
      primary_key :id
      string :word
    end
  end
end
