class Authorization
  
  attr_accessor :authorizer

  def initialize
    json_file_path = Pathname.pwd.to_s + '/client_id.json'
    authorize_info = open(json_file_path) { |io| JSON.load(io) }['web']

    @user_id = authorize_info['project_id']
    @client_id = Google::Auth::ClientId.new(authorize_info['client_id'], authorize_info['client_secret'])
    @scope = [Google::Apis::CalendarV3::AUTH_CALENDAR]
    @token_store = Google::Auth::Stores::FileTokenStore.new(file: Pathname.pwd.to_s + '/token_store')

    @authorizer = Google::Auth::UserAuthorizer.new(@client_id, @scope, @token_store, 'https://google.com')
  end

  def authorization_url
    authorizer.get_authorization_url
  end

  def store_credential(code)
    params = {
      user_id: @user_id,
      code: code,
      scope: "https://www.googleapis.com/auth/calendar",
      base_url: "https://google.com"
    }
    
    authorizer.get_and_store_credentials_from_code(params)
  end

  def get_credential
    authorizer.get_credentials(@user_id)
  end

end
