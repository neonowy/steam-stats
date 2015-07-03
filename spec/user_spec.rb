RSpec.describe SteamStats::User do
  let (:user) { user = SteamStats::User.new 'pewdie' }

  before do
    Dir.chdir(File.dirname(__FILE__))

    user_response_file = File.new('data/user.html')
    stub_request(:any, 'http://steamcommunity.com/id/pewdie').
      to_return(body: user_response_file.read, status: 200)

    games_response_file = File.new('data/games.html')
    stub_request(:any, 'http://steamcommunity.com/id/pewdie/games/?tab=all').
      to_return(body: games_response_file.read, status: 200)
  end

  it 'gets user name' do
    expect(user.name).to eq 'Poods'
  end

  it 'gets user real name' do
    expect(user.real_name).to eq 'Felix Kjellberg'
  end

  it 'gets user avatar' do
    expect(user.avatar).to
      eq 'http://cdn.akamai.steamstatic.com/steamcommunity/public/images/avatars/b9/b9a781a894d319c1a1331a35fc17adf9b02fee76_full.jpg'
  end

  it 'gets user country' do
    expect(user.country).to eq 'SE'
  end

  it 'gets user level' do
    expect(user.level).to eq 12
  end

  it 'checks if user online' do
    expect(user.is_online?).to be false
  end

  it 'gets games' do
    expect(user.games).to
      include({ name: 'Call of Duty: Modern Warfare 2 - Multiplayer', played_hours: 914 }, { name: 'VVVVVV', played_hours: 0.1 })
  end

  context 'not played game' do
    it 'returns 0 played_hours' do
      expect(user.games).to include({ name: 'LIMBO', played_hours: 0 })
    end
  end
end
