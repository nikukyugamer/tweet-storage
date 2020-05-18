module Database
  class SaveList
    def self.create(list)
      list = List.new(
        id_number: list.id,
        name: CGI.unescapeHTML(list.name),
        slug: CGI.unescapeHTML(list.slug),
        serialized_object: list.to_json
      )

      list.save
    end
  end
end
