class UsersController < ApplicationController
before_action :find_user, only:[:show]
    def new
        @user=User.new
        @errors=flash[:errors]
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            log_user_in(@user)
            redirect_to @user
        else
            flash[:errors]=@user.errors.full_messages
            redirect_to new_user_path
        end
    end

    def show
    end


    private 
    def user_params
        params.require(:user).permit(:name,:password,:password_confirmation)
    end

    def find_user
        @user=User.find(params[:id])
    end

end
