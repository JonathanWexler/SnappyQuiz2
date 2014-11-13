class User < ActiveRecord::Base
	TEMP_EMAIL_PREFIX = 'change@me'
	TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  :trackable, :validatable, :omniauthable , :omniauth_providers => [:facebook]
  
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates_uniqueness_of :username

  scope :sorted, lambda {order("users.last_name ASC, first_name ASC")}


#   def self.find_for_oauth(auth, signed_in_resource = nil)

#     # Get the identity and user if they exist
#     identity = Identity.find_for_oauth(auth)

#     # If a signed_in_resource is provided it always overrides the existing user
#     # to prevent the identity being locked with accidentally created accounts.
#     # Note that this may leave zombie accounts (with no associated identity) which
#     # can be cleaned up at a later date.
#     user = signed_in_resource ? signed_in_resource : identity.user

#     # Create the user if needed
#     if user.nil?

#       # Get the existing user by email if the provider gives us a verified email.
#       # If no verified email was provided we assign a temporary email and ask the
#       # user to verify it on the next step via UsersController.finish_signup
#       email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
#       email = auth.info.email if email_is_verified
#       user = User.where(:email => email).first if email

#       # Create the user if it's a new registration
#       if user.nil?
#       	user = User.new(
#       		name: auth.extra.raw_info.name,
#           #username: auth.info.nickname || auth.uid,
#           email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
#           password: Devise.friendly_token[0,20]
#           )
#       	# user.skip_confirmation!
#       	user.save!
#       end
#   end

#     # Associate the identity with the user if needed
#     if identity.user != user
#     	identity.user = user
#     	identity.save!
#     end
#     user
# end

def email_verified?
	self.email && self.email !~ TEMP_EMAIL_REGEX
end

def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    where(conditions).first
  end
end

  # defines login for anywhere in code that uses user and login attribute
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      user.update_attributes(
        first_name:auth.info.first_name,
        last_name:auth.info.last_name,
        provider:auth.provider,
        uid:auth.uid,
        fb_token:auth.credentials.token)
      # user.use_facebook_photo (user)
      return user
    else

      # If they are logging in with Facebook for the first time but have used their email before
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        registered_user.update_attributes(
          first_name:auth.info.first_name,
          last_name:auth.info.last_name,
          provider:auth.provider,
          uid:auth.uid,
          fb_token:auth.credentials.token)
          # if auth.info.image.present?
          #   puts 'SI, ITS PRESENT ******'
          #   avatar_url = process_uri(auth.info.image)
          #   registered_user.avatar = URI.parse(auth.info.image)

            # registered_user.update_attribute(:avatar, URI.parse(avatar_url))
          # end
        # end
        # registered_user.use_facebook_photo (registered_user)
        return registered_user
      else

        # If this is the first time ever logging in with facebook, log them in this way
        user = User.create(
          first_name:auth.info.first_name,
          last_name:auth.info.last_name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.info.email,
          password:Devise.friendly_token[0,20]
          )
      end    
    end
  end

  def use_facebook_photo (registered_user)
    if self.fb_token.present?
      puts 'Token is Present'
      @graph = Koala::Facebook::API.new(fb_token)
      # profile = @graph.get_object("me")
      # friends = @graph.get_connections("me", "friends")
      # facebook = profile.facebook_connection.facebook_api
      # remote_photo_url = facebook.get_picture(profile.facebook_connection.uid, :type => "large")          
      registered_user.avatar = @graph.get_picture(registered_user.uid, :type => "large")
      registered_user.save
    end
  end

end
