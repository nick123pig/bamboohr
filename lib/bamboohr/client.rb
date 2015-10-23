require 'httparty'

module BambooHR
  class Client
    include HTTParty
    format :json

    base_uri "https://api.bamboohr.com"

    attr_accessor :key, :subdomain

    def initialize(params={})
      @key = params[:key]
      @subdomain = params[:subdomain]
    end

    def employee_list
      JSON.parse(api_get('v1/employees/directory').body)['employees']
    end

    def time_off
      JSON.parse(api_get('v1/time_off/requests').body)
    end

    def whos_out
      JSON.parse(api_get('v1/time_off/whos_out').body)
    end

    private

    def headers
      { 'Accept' => 'application/json' }
    end

    def auth
      { username: key, password: "x" }
    end

    def api_get(api_path)
      self.class.get("/api/gateway.php/#{subdomain}/#{api_path}", basic_auth: auth, headers: headers)
    end

  end
end
