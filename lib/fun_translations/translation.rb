# frozen_string_literal: true

module FunTranslations
  # This class represents a response returned by FunTranslation API
  class Translation
    attr_reader :translated_text, :original_text, :translation, :audio, :speed, :tone

    # Initializes a new Translation object
    def initialize(raw_translation)
      translated = raw_translation['translated']

      if translated.respond_to?(:key?) && translated.key?('audio')
        @audio = translated['audio']
      else
        @translated_text = translated
      end

      @original_text = raw_translation['text']
      @translation = raw_translation['translation']
      @speed = raw_translation['speed']
      @tone = raw_translation['tone']
    end
  end
end
