class Api::V1::AuthenticationController < Api::V1::ApiController
  skip_before_action :authenticate_usuario!, only: [:create]

  def create
    usuario = Usuario.find_by(email: params[:email])
    if usuario&.valid_password?(params[:password])
      render json: { token: JsonWebToken.encode(sub: usuario.id) }
    else
      render plain: 'Usuário ou senha incorretos.', status: :unauthorized
    end
  end

  def fetch
    render json: current_usuario
  end
end
