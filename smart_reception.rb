class SmartReception < Sinatra::Base
  before do
    @main_copy = '子供とお年寄りの心と健康'
  end

  set :public_folder => "public", :static => true

  get "/" do
    @ok_count = Keen.count("ok_count")
    @ng_count = Keen.count("ng_count")  
    erb :index
  end

  get "/index" do
    erb :index
  end

  get "/ok" do
    Keen.publish(:ok_count, { :count => 1 })
    erb :thanks
  end

  get "/ng" do
    Keen.publish(:ng_count, { :count => 1 })
    erb :thanks
  end

  get "/analytics" do
    erb :analytics
  end
end
