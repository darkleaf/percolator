class Web::SessionsController < Web::ApplicationController
  skip_before_filter :authenticate!, only: %i[create]

  def create
    sign_in if session_params[:password] == Figaro.env.password
    redirect_to root_path
  end

  def destroy
    sign_out
    redirect_to root_path
  end

private
  def session_params
    params.require(:session).permit(:password)
  end
end
