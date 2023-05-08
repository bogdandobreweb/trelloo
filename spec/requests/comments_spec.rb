# frozen_string_literal: true

require 'swagger_helper'

describe 'Comments API' do
  path '/boards/1/stories/1/comments' do
    post 'Creates a comment' do
      tags 'Comments'
      security [bearerAuth: []]
      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: ['body']
      }

      response '201', 'comment created' do
        let(:comment) { { body: 'Test comment' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:comment) { { body: nil } }
        run_test!
      end
    end
  end
end
