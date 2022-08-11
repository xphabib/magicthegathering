require "json"
require "uri"
require "net/http"
url = URI("https://api.magicthegathering.io/v1/cards")
https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true
request = Net::HTTP::Get.new(url)
response = https.request(request)
cards = JSON.parse(response.read_body)['cards']
ktk_arr = []

cards.each do |card|
    if card['set'] == 'KTK' && !(['red', 'blue'] - card['colors']).empty?
        ktk_arr << card
    end
end

result = {'KTK' => ktk_arr}
p result