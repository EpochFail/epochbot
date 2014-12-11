Sequel.migration do
  up do
    DB.transaction do
      DB[:dictionary_words].delete
      words = File.readlines('eowl.txt').map { |x| [x.strip] }
      DB[:dictionary_words].import [:word], words, :slice => 100
    end
  end

  down do
    # down code
  end
end
