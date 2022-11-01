# frozen_string_literal: true

module FunTranslations
  # This module prepares a connection object
  module Connection
    BASE_URL = 'https://api.funtranslations.com'

    # Prepares a new connection object
    # @param client [FunTranslations::Client]
    def connection(client)
      Faraday.new(options(client)) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.request :url_encoded
      end
    end

    private

    def options(client)
      headers = {
        accept: 'application/json',
        'Content-Type' => 'application/x-www-form-urlencoded',
        user_agent: "fun_translations gem/#{FunTranslations::VERSION}"
      }

      headers['X-Funtranslations-Api-Secret'] = client.token unless client.token.nil?

      {
        headers: headers,
        url: BASE_URL
      }
    end
  end
end
