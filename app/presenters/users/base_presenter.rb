module Users
  class BasePresenter
    def initialize(user)
      @user = user
    end

    def as_json(*)
      raise NotImplementedError, "Subclasses must implement the as_json method"
    end
  end
end
