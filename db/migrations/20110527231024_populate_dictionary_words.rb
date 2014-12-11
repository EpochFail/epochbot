Sequel.migration do
  up do
    words = File.readlines('english.0').map { |x| [x.strip] }
    DB[:dictionary_words].import [:word], words, :slice => 100
  end

  down do
    DB[:dictionary_words].delete
  end
end
