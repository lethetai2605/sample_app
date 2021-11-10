class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    before_save :downcase_email        #{ email.downcase! }
    before_create :create_activation_digest
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 3 }
    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
            BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end
        
        def new_token
            SecureRandom.urlsafe_base64
        end
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
        remember_digest
    end

    def session_token
        remember_digest || remember
    end
    
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # def authenticated?(remember_token)
    #     digest = self.send("remember_digest")

    #     return false if remember_digest.nil?
    #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end

    def forget
        update_attribute(:remember_digest, nil)
    end
    
    # Activates an account.
    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end
    # Sends activation email.
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    private
        def downcase_email
            self.email = email.downcase
        end
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
end