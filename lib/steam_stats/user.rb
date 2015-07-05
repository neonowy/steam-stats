module SteamStats
  class User
    attr_reader :name, :real_name, :avatar, :country, :level, :games

    def initialize(user_id)
      @id = user_id

      @user_url = get_user_url
      @games_url = get_games_url

      @user_page = Nokogiri::HTML(open(@user_url))
      @games_page = Nokogiri::HTML(open(@games_url))

      @games = []

      fetch_info
      fetch_games
    end

    def is_online?
      @online
    end

    private
    def fetch_info
      @name = @user_page.css('.actual_persona_name')[0].text
      @real_name = @user_page.css('.header_real_name.ellipsis bdi')[0].text
      @avatar = @user_page.css('.playerAvatar img')[0]['src']
      @country = @user_page.css('.profile_flag')[0]['src'][-6..-5].upcase rescue nil
      @level = @user_page.css('.persona_name .friendPlayerLevelNum').text.to_i

      if @user_page.css('.profile_in_game_header').nil?
        @online = true
      else
        @online = false
      end
    end

    def fetch_games
      @games_js = @games_page.css('script[language=javascript]')[0].text
      @games_json = /rgGames = (\[.+\]);/.match(@games_js)[1]
      @games_raw = JSON.parse(@games_json)

      JSON.parse(@games_json).each do |element|
        played_hours = element['hours_forever'].to_f
        name = element['name']

        game = { name: name, played_hours: played_hours }

        @games.push(game)
      end
    end

    def get_user_url
      if is_number?(@id)
        "http://steamcommunity.com/profiles/#{@id}"
      else
        "http://steamcommunity.com/id/#{@id}"
      end
    end

    # Warning! Call only after get_user_url
    def get_games_url
      "#{@user_url}/games/?tab=all"
    end

    def is_number?(string)
      true if Float(string) rescue false
    end
  end
end
