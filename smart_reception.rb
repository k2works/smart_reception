class SmartReception < Sinatra::Base
  before do
    @vision = 'お年寄りの孤独をなくす'
    @vision_copy = '学生との話し合いの場を作ります'
    @thanks = <<-'MSG'
      Thank you!</h2>
      <p class="lead">ご協力ありがとうございます。頂いたご意見を元に更にサービスを改善させて行きたいと思います。</p>
      </div>
    MSG
    @base = 'base'
    @case01 = 'case01'
    @setting = @base
  end

  set :public_folder => "public", :static => true

  get "/" do
    case @setting
    when @base
      @ok_base_count = Keen.count("ok_count_base")
      @ng_base_count = Keen.count("ng_count_base")

      value = "block01"
      keen_filters = [property_name:"block",operator:"eq",property_value:value]
      @ok_block01_count = Keen.sum("ok_count_base",{target_property:"count",filters:keen_filters})
      @ng_block01_count = Keen.sum("ng_count_base",{target_property:"count",filters:keen_filters})

      value = "block02"
      keen_filters = [property_name:"block",operator:"eq",property_value:value]
      @ok_block02_count = Keen.sum("ok_count_base",{target_property:"count",filters:keen_filters})
      @ng_block02_count = Keen.sum("ng_count_base",{target_property:"count",filters:keen_filters})

      value = "block03"
      keen_filters = [property_name:"block",operator:"eq",property_value:value]
      @ok_block03_count = Keen.sum("ok_count_base",{target_property:"count",filters:keen_filters})
      @ng_block03_count = Keen.sum("ng_count_base",{target_property:"count",filters:keen_filters})

      value = "price"
      keen_filters = [property_name:"block",operator:"eq",property_value:value]
      @ok_price_count = Keen.sum("ok_count_base",{target_property:"count",filters:keen_filters})
      @ng_price_count = Keen.sum("ng_count_base",{target_property:"count",filters:keen_filters})

      value = "last"
      keen_filters = [property_name:"block",operator:"eq",property_value:value]
      @ok_last_count = Keen.sum("ok_count_base",{target_property:"count",filters:keen_filters})
      @ng_last_count = Keen.sum("ng_count_base",{target_property:"count",filters:keen_filters})

    end

    base

    erb :index
  end

  get "/ok/:case/?:block" do |arg1,arg2|
    set_ok_metric(arg1,arg2)
    erb :thanks
  end

  get "/ng/:case/?:block" do |arg1,arg2|
    set_ng_metric(arg1,arg2)
    erb :thanks
  end

  get "/thanks" do
    erb :thanks
  end

  get "/analytics" do
    erb :analytics
  end

  def set_ok_metric(metric_type,block)
    case metric_type
    when @base
      Keen.publish(:ok_count_base, { :count => 1, :block => block })
    else
      Keen.publish(:ok_count, { :count => 1, :block => block })
    end
  end

  def set_ng_metric(metric_type,block)
    case metric_type
    when @base
      Keen.publish(:ng_count_base, { :count => 1, :block => block })
    else
      Keen.publish(:ng_count, { :count => 1, :block => block })
    end
  end

  def base
    @section_heading_01 = <<-'MSG'
      <h2 class="section-heading">
      孤独を感じているお年寄りはたくさんいます。
      </h2>
      <p class="lead">
      お年寄りの中には、話し相手や友達がいないという方がたくさんいます。
      </p>
      MSG

    @section_heading_02 = <<-'MSG'
      <h2 class="section-heading">
      私たちはそんなお年寄りの方に、学生を紹介します。
      </h2>
      <p class="lead">
      お年寄りの方とカウンセラー志望の学生を繋げるサービスを提供します。
      </p>
      MSG

    @section_heading_03 = <<-'MSG'
      <h2 class="section-heading">
      特別なサービス
          <br>年表</h2>
      <p class="lead">
      学生がお年寄りの話を聞き、そのお年寄りの年表を作成します。
      </p>
      MSG

    @section_heading_04 = <<-'MSG'
      <h2 class="section-heading">
      サービスの価格
          <br></h2>
      <p class="lead">
      類似サービスの平均価格に比べお手軽な良心価格です。
      </p>
      MSG

    @last_question = 'このサービスってアリですかね？'
    @metric_type = @base
  end

  def case01
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
    @metric_type = @case01
  end
end
