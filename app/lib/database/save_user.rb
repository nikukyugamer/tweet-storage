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

    def self.update(user_id_number)
      user = User.where(id_number: user_id_number).latest

      user.update(
        id_number: user.id,
        handle: CGI.unescapeHTML(user.name),
        screen_name: CGI.unescapeHTML(user.screen_name),
        serialized_object: user.to_json
      )
    end
  end
end
