class SessionsController < ApplicationController


    def new
        redirect_to current_user unless !current_user
    end

    def create
        @user=User.find_by(name:user_params[:name])
        if @user && @user.authenticate(user_params[:password])
            log_user_in(@user)
            flash[:notice]="Log in was successful"
            redirect_to @user
        else
            flash[:notice]="Wrong credentials"
            redirect_to login_path
        end
    end

    def destroy
        session[:user_id]=nil
        redirect_to login_path
    end

    private
    def user_params
        params.require(:user).permit(:name,:password)
    end
end