require_relative "spec_helper"
require_relative "../smart_reception.rb"

def app
  SmartReception
end

describe SmartReception do
  it "responds with a welcome message" do
    get '/'

    last_response.body.must_include 'Welcome to the Sinatra Template!'
  end
end
