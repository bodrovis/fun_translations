# frozen_string_literal: true

require 'zeitwerk'
require 'faraday'

loader = Zeitwerk::Loader.for_gem
loader.setup

module FunTranslations
  class << self
    def client(token = nil)
      FunTranslations::Client.new token
    end
  end
end
