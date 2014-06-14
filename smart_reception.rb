class SmartReception < Sinatra::Base

  set :public_folder => "public", :static => true

  get "/" do
    erb :welcome
  end

  get "/index" do
    erb :index
  end

  get "/index2" do
    erb :index2
  end
end
