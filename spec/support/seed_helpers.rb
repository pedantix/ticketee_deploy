module SeedHelpers
  def create_user!(attributes = {})
    user = FactoryGirl.create(:user, attributes)
    user.confirm!
    user
  end
end
