module Database
  class SaveUser
    def self.create(user)
      user = User.new(
        id_number: user.id,
        handle: CGI.unescapeHTML(user.name),
        screen_name: CGI.unescapeHTML(user.screen_name),
        serialized_object: user.to_json
      )

      user.save
    end
  end
end
