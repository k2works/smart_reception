class SmartReception < Sinatra::Base
  before do
    @vision = 'お年寄りの孤独をなくす'
    @vision_copy = '学生との話し合いの場を作ります'
    @thanks = <<-'MSG'
      Thank you!</h2>
      <p class="lead">ご協力ありがとうございます。頂いたご意見を元に更にサービスを改善させて行きたいと思います。</p>
      </div>
    MSG
  end

  set :public_folder => "public", :static => true

  get "/" do
    @ok_count = Keen.count("ok_count")
    @ng_count = Keen.count("ng_count")

    base

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

  get "/thanks" do
    erb :thanks
  end

  get "/analytics" do
    erb :analytics
  end

  def base
    @section_heading_01 = <<-'MSG'
    <h2 class="section-heading">
    孤独なお年寄りへ:
        <br>人生を聞いてほしいと思いませんか?</h2>
    <p class="lead">
    話が相手がいなくて寂しい思いをしていませんか？
    </p>
    MSG

    @section_heading_02 = <<-'MSG'
    <h2 class="section-heading">
    お年寄りのお話し相手を作るサービスです
    <br></h2>
    <p class="lead">
    学生がお話相手になって年表を作ります。
    </p>
    MSG

    @section_heading_03 = <<-'MSG'
    <h2 class="section-heading">
    特別なサービス
        <br>年表</h2>
    <p class="lead">
    あなたの生きた証を作成します。
    </p>
    MSG

    @section_heading_04 = <<-'MSG'
    <h2 class="section-heading">
    サービスの価格
        <br></h2>
    <p class="lead">
    お手軽な良心価格です。
    </p>
    MSG

    @last_question = 'このサービスってアリですかね？'
  end

  def case01
    @section_heading_01 = <<-'MSG'
    Death to the Stock Photo:
        <br>Special Thanks</h2>
    <p class="lead">A special thanks to Death to the Stock Photo for providing the photographs that you see in this template. <a target="_blank" href="http://join.deathtothestockphoto.com/">Visit their website</a> to become a member.</p>
    MSG

    @section_heading_02 = <<-'MSG'
    3D Device Mockups
        <br>by PSDCovers</h2>
    <p class="lead">Turn your 2D designs into high quality, 3D product shots in seconds using free Photoshop actions by PSDCovers! <a target="_blank" href="http://www.psdcovers.com/">Visit their website</a> to download some of their awesome, free photoshop actions!</p>
    MSG

    @section_heading_03 = <<-'MSG'
    Google Web Fonts and
        <br>Font Awesome Icons</h2>
    <p class="lead">This template features the 'Lato' font, part of the <a target="_blank" href="http://www.google.com/fonts">Google Web Font library</a>, as well as <a target="_blank" href="http://fontawesome.io">icons from Font Awesome</a>.</p>
    MSG

    @last_question = 'このサービスってアリですかね？'
  end
end
