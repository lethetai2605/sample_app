module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    # def current_user
    #     if session[:user_id]
    #         @current_user ||= User.find_by(id: session[:user_id])
    #     end
    # end

    def current_user
            if (user_id = session[:user_id])
                # user = User.find_by(id: user_id)
                 @current_user ||= User.find_by(id: user_id)
                # @current_user ||= user if !session[:session_token].nil?
            elsif (user_id = cookies.encrypted[:user_id])
                user = User.find_by(id: user_id)
                if user && user.authenticated?(cookies[:remember_token])
                    log_in user
                    @current_user = user
                end
            end
    end

    # Returns true if the given user is the current user.
    def current_user?(user)
        user && user == current_user
    end

    def logged_in?
        !current_user.nil?
    end

    def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def forget(user)
        if !cookies[:user_id].nil?
        user.forget #xoa remember_digest
        cookies.delete(:user_id) #xoa id
        cookies.delete(:remember_token) #xoa remember_token 
        end
    end

    def log_out
        forget(current_user)
        reset_session
        @current_user = nil
    end

    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
end
