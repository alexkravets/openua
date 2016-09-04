# Bot commands:
# help - как пользоваться ботом

class BotService
  HELLO_MSG = '✌Привет'
  ONBOARDING_MSG = 'Я помогу тебе следить за тендерами.'
  HELP_MSG = 'Отправь мне ID тендера и я буду присылать тебе уведомления о его изменениях.'
  TENDER_NOT_FOUND_MSG = '😁 Тендер с этим ID не найден.'
  OK_MSG = '👍'

  attr_reader :user_id
  attr_reader :user_name
  attr_reader :text
  attr_reader :telegram
  attr_reader :tender

  def initialize(msg_object)
    message    = msg_object[:message]
    @user_id   = message[:from][:id]
    @user_name = message[:from][:first_name] || message[:from][:username]
    @text      = message[:text]

    if @text
      @telegram = TelegramService.new
      @telegram.send_chat_action(@user_id, 'typing')

      if @text.start_with? '/start'
        start

      elsif @text.start_with? '/help'
        @telegram.send_message(@user_id, HELP_MSG)

      else
        create_alert

      end
    end
  end

  def start
    greeting = [HELLO_MSG, @user_name].compact.join(', ')
    reply    = "#{greeting}!\n#{ONBOARDING_MSG} #{HELP_MSG}"
    @telegram.send_message(@user_id, reply)
  end

  def create_alert
    tender_id = @text.strip
    @tender = Tender.or({ open_procurement_id: tender_id },
                        { tender_id: tender_id }).first

    if @tender
      Alert.find_or_create_by(tender_id: @tender.id.to_s, user_id: @user_id)

      reply = "#{OK_MSG} https://prozorro.gov.ua/tender/#{@tender.tender_id}/"
      @telegram.send_message(@user_id, reply)

    else
      @telegram.send_message(@user_id, TENDER_NOT_FOUND_MSG)

    end
  end
end
