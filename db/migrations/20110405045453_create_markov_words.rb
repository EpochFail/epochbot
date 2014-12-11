Sequel.migration do
  change do
    create_table :markov_words do
      primary_key :id
      string :leader
      string :follower
      integer :count
    end
  end
end
