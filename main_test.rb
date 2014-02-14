ENV['RACK_ENV'] = 'test'
ENV['S2S_TOKEN'] = 'abcd1234'
ENV['S2S_TARGET'] = 'http://example.com?foo=bar'

require './main'
require "minitest/autorun"
require "rack/test"

class MainTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_posts_to_target
    Object.stub(:faraday_post, body) do
      assert_equal body, "foo"
    end
    post_body = '{"branch_name":"handle-exceptions-in-workers","branch_url":"https://semaphoreapp.com/marcocampana/pick1-5-0/branches/handle-exceptions-in-workers","project_name":"pick1-5-0","build_url":"https://semaphoreapp.com/marcocampana/pick1-5-0/branches/handle-exceptions-in-workers/builds/2","build_number":2,"result":"passed","started_at":"2014-02-13T18:20:16+01:00","finished_at":"2014-02-13T18:37:49+01:00","commit":{"id":"de37b7365ebc75076aab87c4d02ae5d2292fb6eb","url":"https://github.com/doochoo/pick1-5.0/commit/de37b7365ebc75076aab87c4d02ae5d2292fb6eb","author_name":"Francesco Levorato","author_email":"git@flevour.net","message":"early return for SM workers if import is stopped","timestamp":"2014-02-13T17:58:22+01:00"}}'
    post "/abcd1234", post_body
  end
end
