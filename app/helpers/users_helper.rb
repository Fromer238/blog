module UsersHelper
  def avatar(user, size: 50)
    image_tag user.avatar.variant(resize: "#{size}x#{size}") if user.avatar.attached?
  end
end

