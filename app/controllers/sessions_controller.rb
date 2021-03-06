class SessionsController < ApplicationController

    
    def destroy
        session.clear
    
        redirect_to '/'
    end

    def new
    end

    def create
        @player = Player.find_by(username: params[:player][:username])

        if @player && @player.authenticate(params[:player][:password])
            session[:player_id] = @player.id
            redirect_to team_player_path(@player.team_id,@player.id)
        else
            flash[:message] = "Incorrect Login Information Please Try Again"
            redirect_to login_path
        end
    end

    def omniauth
        
        @player = Player.find_or_create_by(email: auth[:info][:email]) do |player|
            player.username = auth[:info][:first_name]
            player.password = SecureRandom.hex(10)
            
        end
        if @player.save
            
        session[:player_id] = @player.id
        redirect_to team_player_path(@player.team_id, @player.id)
        else
        redirect_to '/'
        end
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end