Sequel.migration do
  change do
    create_table :golf_players do
      primary_key :id
      string :nick
      bool :playing
      bool :played_round
      integer :game_score, :default => 0
      integer :total_score, :default => 0
      integer :total_strokes, :default => 0
      integer :wins, :default => 0
    end
  end
end
