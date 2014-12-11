Sequel.migration do
  up do
    alter_table :links do
      add_column :host, String
    end

    class Link < Sequel::Model(:links)
    end

    Link.all.each do |link|
      link.update host: URI(URI.escape(link.url)).host
    end
  end

  down do
    alter_table :links do
      drop_column :host
    end
  end
end
