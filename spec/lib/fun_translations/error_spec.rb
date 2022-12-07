# frozen_string_literal: true

RSpec.describe FunTranslations::Error do
  include FunTranslations::Request

  it 'handles error 400' do
    data = {
      error: {
        code: 400,
        message: 'Bad Request: text is missing.'
      }
    }
    stub_request(:post, 'https://api.funtranslations.com/translate/yoda.json').
      to_return(
        status: 400,
        body: JSON.dump(data)
      )

    expect do
      post(
        '/translate/yoda.json',
        test_client,
        text: nil
      )
    end.to raise_error(described_class::BadRequest, /text is missing/)
  end

  it 'handles error 404' do
    data = {
      error: {
        code: 404,
        message: 'Not Found'
      }
    }
    stub_request(:post, 'https://api.funtranslations.com/translate/fake.json').
      to_return(
        status: 404,
        body: JSON.dump(data)
      )

    expect do
      post(
        '/translate/fake.json',
        test_client,
        text: ''
      )
    end.to raise_error(described_class::NotFound, /Not Found/)
  end

  it 'handles error 429' do
    data = {
      error: {
        code: 429,
        message: 'Too Many Requests: Rate limit of 5 requests per hour exceeded.'
      }
    }
    stub_request(:post, 'https://api.funtranslations.com/translate/yoda.json').
      to_return(
        status: 429,
        body: JSON.dump(data)
      )

    expect do
      post(
        '/translate/yoda.json',
        test_client,
        text: 'My text'
      )
    end.to raise_error(described_class::TooManyRequests, /Rate limit of 5 requests/)
  end

  it 'handles unknown error codes' do
    data = {
      error: {
        code: 430,
        message: 'Unknown error.'
      }
    }
    stub_request(:post, 'https://api.funtranslations.com/translate/yoda.json').
      to_return(
        status: 430,
        body: JSON.dump(data)
      )

    expect do
      post(
        '/translate/yoda.json',
        test_client,
        text: 'My text'
      )
    end.to raise_error(described_class, 'Unknown error.')
  end
end
