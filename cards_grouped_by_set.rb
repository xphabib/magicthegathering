require "json"
require "uri"
require "net/http"
url = URI("https://api.magicthegathering.io/v1/cards")
https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true
request = Net::HTTP::Get.new(url)
response = https.request(request)
cards = JSON.parse(response.read_body)['cards']
group_by_set = {}

cards.each do |card|
    if group_by_set["#{card['set']}"]
        group_by_set["#{card['set']}"] << card
    else
        group_by_set["#{card['set']}"] = [card]
    end
end

p group_by_set