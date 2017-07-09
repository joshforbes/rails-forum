require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def json_response
    JSON.parse(response.body)
  end
end
