class UserFetcherService

  Response = Struct.new(:success, :user, :error)

  def initialize(user_id:)
    @user_id = user_id
  end

  def call
    user = Endpoints::User.get_user(user_id: user_id)

    if user
      Response.new(success: true, user: user)
    else
      Response.new(success: false, error: "User not found")
    end
  rescue StandardError => e
    { success: false, error: e.message }
  end

  private

  attr_reader :user_id
end
