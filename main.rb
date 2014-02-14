require 'sinatra'
require 'dotenv'
require 'faraday'
require 'json'
Dotenv.load

post "/#{ENV['S2S_TOKEN']}" do
  json = JSON.load(request.env["rack.input"].read)
  commit = json["commit"]
  text = "[#{json["project_name"]}/#{json["branch_name"]}] #{json["result"]}: #{commit["message"]} - #{commit["author_name"]} (<#{json["build_url"]}|build #{json["build_number"]}|>)"
  hook = {
    "text" => text,
    "icon_emojo" => json["result"] == "passed" ? ":white_check_mark:" : ":no_entry:",
  }
  faraday_post(JSON.dump(hook))
end

def faraday_post(body)
  conn = Faraday.new(:url => ENV['S2S_TARGET'])
  conn.post do |req|
    req.headers['Content-Type'] = 'application/json'
    req.body = body
  end
end
