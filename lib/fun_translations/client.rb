# frozen_string_literal: true

module FunTranslations
  # FunTranslations API client
  class Client
    include FunTranslations::Request

    attr_accessor :token

    def initialize(token = nil)
      @token = token
    end

    # Performs translation
    # @return [FunTranslations::Translation]
    # @param endpoint [String, Symbol]
    # @param text [String]
    # @param params [Hash]
    def translate(endpoint, text, params = {})
      FunTranslations::Translation.new(
        post(
          "/translate/#{endpoint}.json",
          self,
          {text: text}.merge(params)
        )
      )
    end
  end
end
