module UsersHelper
  
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  # Returns the profile picture for the given user.
  def profile_picture_for(user)
    if user.picture?
      image_tag(user.picture.url, alt: user.name, class: "profile_picture")
    else
      image_tag(random_default_image, alt: user.name, class: "profile_picture")
    end
  end
  
  # Returns a random image from the default 6
  def random_default_image
    Random.new.rand(1..6).to_s + '.jpg'
  end
end
