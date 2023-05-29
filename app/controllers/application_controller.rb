class ApplicationController < ActionController::Base
  def current_usuario
    return Usuario.first
  end
end
