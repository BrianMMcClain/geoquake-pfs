require 'sinatra'
require 'httparty'

class GeoQuake < Sinatra::Base

    configure do
        set :events_api, ENV["EVENTS_API"] || "http://localhost:8080"
    end

    get '/' do
        content_type "text/html"
        File.open("index.html", 'rb', &:read)
    end

    get '/events' do
        content_type :json
        response = HTTParty.get(settings.events_api)
        return response.body
    end

    get '/*' do
        case request.path.split(".").last
        when "css"
            content_type "text/css"
        when "js"
            content_type "text/javascript"
        when "png"
            content_type "image/png"
        else
            content_type "text/html"
        end

        body = File.open(".#{request.path}", 'rb', &:read)
        return body
    end

end