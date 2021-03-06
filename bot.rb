require_relative('./lib/logic.rb')
require 'telegram/bot'

token = 'goes here'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} let's find you something to eat")
      bot.api.send_message(chat_id: message.chat.id, text: "Tell me what to do with: \n /food to get a dish recommendation \n /stop to finish")
    when '/food'
      recommendation = Dishes.recommend
      bot.api.send_message(chat_id: message.chat.id, text: "What about #{recommendation[0]}? It's a great #{recommendation[1]} dish!")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Enjoy your meal, #{message.from.first_name}! \n Goodbye :)")
    end
  end
end
