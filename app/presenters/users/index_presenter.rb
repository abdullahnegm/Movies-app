module Users
  class IndexPresenter < BasePresenter
    def as_json(*)
      {
        name: @user.name,
        username: @user.username
      }
    end
  end
end
