class V1::MessagesController < ApplicationController
  def index
    render json: [{ message_id: 2, title: "Mensagem de teste" }, message_id: 3, title: "Outra mensagem de teste"]
  end
end
