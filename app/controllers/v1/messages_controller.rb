class V1::MessagesController < ApplicationController
  def index
    render json: load_messages
  end

  private

  def load_messages
    [
      { message_id: 2, title: "Mensagem de teste" },
      { message_id: 3, title: "Outra mensagem de teste" },
      { message_id: 4, title: "Ainda outra mensagem de teste" },
      { message_id: 5, title: "Ainda outra mensagem de teste" },
      { message_id: 6, title: "mais uma, só pra ve" },
      { message_id: 7, title: "mais uma, só pra ve" }
    ]
  end
end
