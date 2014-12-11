Sequel.migration do
  change do
    create_table :markov_enders do
      primary_key :id
      string :word
      integer :count
    end
  end
end
