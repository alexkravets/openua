class TelegramController < ActionController::Base
  def receive
    telegram = params[:telegram]

    ap '<<<'
    ap telegram.to_unsafe_hash

    BotService.new(telegram)
    head :ok, content_type: 'text/html'
  end
end
