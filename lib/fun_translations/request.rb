# frozen_string_literal: true

module FunTranslations
  # This module contains methods to perform HTTP requests
  module Request
    include FunTranslations::Connection

    # Performs an HTTP post request
    # @param path [String]
    # @param client [FunTranslations::Client]
    # @param params [Hash]
    def post(path, client, params = {})
      respond_with(
        connection(client).post(path, params)
      )
    end

    private

    # Parses response body using JSON
    # or raises an error if the status code is not 2xx
    def respond_with(response)
      raw_body = response.body
      body = raw_body.empty? ? raw_body : JSON.parse(raw_body)

      respond_with_error(response.status, body['error']) if body.key?('error') || !response.success?

      body['contents']
    end

    def respond_with_error(code, body)
      raise(FunTranslations::Error, body) unless FunTranslations::Error::ERRORS.key? code

      raise FunTranslations::Error::ERRORS[code].from_response(body)
    end
  end
end
