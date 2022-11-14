# frozen_string_literal: true

require 'zeitwerk'
require 'faraday'
require 'json'

loader = Zeitwerk::Loader.for_gem
loader.setup

# This is a Ruby client that enables you to easily perform translations using FunTranslations API:
#
#   client = FunTranslations.client
#   translation_yoda = client.translate :yoda, "Hello, my padawan"
#   translation_yoda.translated_text
module FunTranslations
  class << self
    # Initializes a new Client object
    #
    # @return [FunTranslations::Client]
    # @param token [String]
    def client(token = nil)
      FunTranslations::Client.new token
    end
  end
end
