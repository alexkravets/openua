namespace :telegram do
  desc "Set Telegram bot's webhook"
  task :set_webhook => :environment do
    webhook_url = "#{ENV['WEBHOOK_URL']}/telegram"
    t = TelegramService.new
    ap webhook_url
    t.set_webhook(webhook_url)
  end

  desc "Remove Telegram bot's webhook"
  task :unset_webhook => :environment do
    t = TelegramService.new
    t.set_webhook('')
  end

  desc "Test Telegram bot's auth token"
  task :test => :environment do
    t = TelegramService.new
    t.get_me
  end
end
