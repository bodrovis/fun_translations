# frozen_string_literal: true

RSpec.describe FunTranslations::Client do
  describe '#translate' do
    it 'translates as yoda with token' do
      text = 'Master Obi Wan lost a planet'
      data = {
        success: {total: 1},
        contents: {
          translated: 'A planet, master obi wan lost',
          text: text,
          translation: 'yoda'
        }
      }
      stub_request(:post, 'https://api.funtranslations.com/translate/yoda.json').
        with(
          body: {text: text},
          headers: {
            'X-Funtranslations-Api-Secret' => 'my token',
            'Content-Type' => 'application/x-www-form-urlencoded',
            'User-Agent' => "fun_translations gem/#{FunTranslations::VERSION}"
          }
        ).
        to_return(
          status: 200,
          body: JSON.dump(data)
        )

      translation = test_client('my token').translate :yoda, text

      expect(translation.translated_text).to eq('A planet, master obi wan lost')
      expect(translation.original_text).to eq(text)
      expect(translation.translation).to eq('yoda')
    end

    it 'translates as yoda' do
      text = 'Master Obi Wan lost a planet'
      data = {
        success: {total: 1},
        contents: {
          translated: 'A planet, master obi wan lost',
          text: text,
          translation: 'yoda'
        }
      }
      stub_request(:post, 'https://api.funtranslations.com/translate/yoda.json').
        with(body: {text: text}).
        to_return(
          status: 200,
          body: JSON.dump(data)
        )

      translation = test_client.translate :yoda, text

      expect(translation.translated_text).to eq('A planet, master obi wan lost')
      expect(translation.original_text).to eq(text)
      expect(translation.translation).to eq('yoda')
    end

    it 'translates with morse audio' do
      text = 'Welcome'
      data = {
        success: {total: 1},
        contents: {
          translated: {audio: 'data:audio/wave;base64,UklGRjiBCQBXQVZFZm1'},
          text: text,
          translation: {
            source: 'english',
            destination: 'morse audio'
          }
        }
      }
      stub_request(:post, 'https://api.funtranslations.com/translate/morse/audio.json').
        with(body: {text: text}).
        to_return(
          status: 200,
          body: JSON.dump(data)
        )

      translation = test_client.translate 'morse/audio', text
      expect(translation.audio).to eq('data:audio/wave;base64,UklGRjiBCQBXQVZFZm1')
      expect(translation.original_text).to eq(text)
      expect(translation.translation['destination']).to eq('morse audio')
    end
  end
end
