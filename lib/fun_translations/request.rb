# frozen_string_literal: true

module FunTranslations
  module Request
    include FunTranslations::Connection

    def post(path, client, params = {})
      respond_with(
        connection(client).post(path, params)
      )
    end

    private

    def respond_with(response)
      body = response.body.empty? ? response.body : JSON.parse(response.body)

      respond_with_error(response.status, body['error']) if body.key?('error') || !response.success?

      body['contents']
    end

    def respond_with_error(code, body)
      raise(FunTranslations::Error, body) unless FunTranslations::Error::ERRORS.key? code

      raise FunTranslations::Error::ERRORS[code].from_response(body)
    end
  end
end
