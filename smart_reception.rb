class SmartReception < Sinatra::Base

  set :public_folder => "public", :static => true

  get "/" do
    erb :index
  end

  get "/index" do
    erb :index
  end

  get "/ok" do
    erb :thanks
  end

  get "/ng" do
    erb :thanks
  end
end
