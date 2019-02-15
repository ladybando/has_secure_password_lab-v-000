class UsersController < ApplicationController
  def password=(new_password)
    salt = BCrypt::Engine::generate_salt
    hashed = BCrypt::Engine::hash_secret(new_password, salt)
    self.password_digest = salt + hashed
  end
 
  # authenticate(password: string) -> User?
  def authenticate(password)
    # Salts generated by generate_salt are always 29 chars long.
    salt = password_digest[0..28]
    hashed = BCrypt::Engine::hash_secret(password, salt)
    return nil unless (salt + hashed) == self.password_digest
  end
  
  def create
    if params[:user][:password] && params[:user][:password] != params[:user][:password_confirmation]
     redirect_to login_path
   else
     @user = User.create(user_params)
     session[:user_id] = @user.id
     redirect_to root_path
   end
 end

    private

    def user_params
     params.require(:user).permit(:name, :password, :password_confirmation)
   end
end