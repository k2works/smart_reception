
スマート受付
===
# 目的
スマート受付プロジェクトランディングページ

# 前提
| ソフトウェア     | バージョン    | 備考         |
|:---------------|:-------------|:------------|
| OS X           |10.8.5        |             |
| ruby      　　　|2.1.1         |             |

# 構成
+ [セットアップ](#1)
+ [プロジェクトセットアップ](#2)
+ [環境設定](#3)
+ [イベント送信](#4)
+ [データ分析と視覚化](#5)
+ [Herokuにアップする](#6)

# 詳細
## <a name="1">セットアップ</a>
```bash
## <a name="2">Keen IOプロジェクトセットアップ</a>
```bash
$ git commit -am "セットアップ"
[master (root-commit) 9f41d55] セットアップ
 19 files changed, 301 insertions(+)
 create mode 100644 Gemfile
 create mode 100644 Gemfile.lock
 create mode 100644 README.md
 create mode 100644 Rakefile
 create mode 100644 config.ru
 create mode 100644 config/db.yml
 create mode 100644 config/initializers/database.rb
 create mode 100644 lib/.gitkeep
 create mode 100644 public/favicon.ico
 create mode 100644 public/images/.gitkeep
 create mode 100644 public/images/hazel_icon.png
 create mode 100644 public/images/hazel_small.png
 create mode 100644 public/javascripts/.gitkeep
 create mode 100644 public/stylesheets/main.css
 create mode 100644 smart_reception.rb
 create mode 100644 spec/smart_reception_spec.rb
 create mode 100644 spec/spec_helper.rb
 create mode 100644 views/layout.erb
 create mode 100644 views/welcome.erb
```

Keen IOにログインして[新しいプロジェクトを作る](https://keen.io/add-project)。  

## <a name="3">環境設定</a>
### Procfle追加
_Procfile_
```
web: bundle exec rackup config.ru -p $PORT
```
### Gemfileの編集
_Gemfile_
```ruby
source "https://rubygems.org/"
ruby "2.1.1"

# App Stack
gem "sinatra", "~> 1.4"
gem "sequel"
gem "pg"
gem "rakuten_web_service"
gem "keen"

group :development,:test do
  gem "sqlite3"
  gem "rake", "~> 10.0"
  gem "minitest", "~> 5.2"
  gem "rack-test", "~> 0.6"
  gem 'guard'
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-stack_explorer'

  if RUBY_VERSION >= '2.0.0'
    gem 'pry-byebug'
  else
    # 以下はRuby1.9の時のみ使う(pry-byebugの代わりに)
    # debuggerは1.9以下でしか動作しない, remote は byebug で使えないようになった
    gem 'pry-debugger'
    gem 'pry-remote'
  end
end
```

### Keen対応
_views/layout.erb_
```ruby
  <script>
  var Keen=Keen||{configure:function(e){this._cf=e},addEvent:function(e,t,n,i){this._eq=this._eq||[],this._eq.push([e,t,n,i])},setGlobalProperties:function(e){this._gp=e},onChartsReady:function(e){this._ocrq=this._ocrq||[],this._ocrq.push(e)}};(function(){var e=document.createElement("script");e.type="text/javascript",e.async=!0,e.src=("https:"==document.location.protocol?"https://":"http://")+"dc8na2hxrj29i.cloudfront.net/code/keen-2.1.0-min.js";var t=document.getElementsByTagName("script")[0];t.parentNode.insertBefore(e,t)})();

  // Configure the Keen object with your Project ID and (optional) access keys.
  Keen.configure({
      projectId: "<%= ENV['KEEN_PROJECT_ID'] %>",
      writeKey: "<%= ENV['KEEN_WRITE_KEY'] %>", // required for sending events
      readKey: "<%= ENV['KEEN_READ_KEY'] %>"    // required for doing analysis
  });
  </script>
```
### .envファイル追加
_.env_ファイルを_.gitignore_ファイルに追加する。

## <a name="4">イベント送信</a>
### 共通設定ファイル追加
_config/initializers/application.rb_
```ruby
require 'sinatra'
require 'keen'
```
### Rakeタスク作成
_Rakefile_
```ruby
namespace :app do |t|
  desc "Rakeタスク"
  task :something_rake do
    require "./config/initializers/application"
  end
end
```
### Rakeタスク実行
```bash
$ foreman run rake app:something_rake
```
## <a name="5">データ分析と視覚化</a>
### 表示用JavaScript追加
_public/javascripts/keenio.js_

### ビュー修正
_views/layout.erb_
```ruby
<script src="javascripts/keenio.js"></script>
```
_views/index.erb_

## <a name="6">Herokuにアップする</a>
### デプロイ
```bash
$ heroku login
$ heroku create
$ heroku addons:add keen
$ heroku config:push
$ git push heroku master
$ heroku apps:rename rakuten-ranking
```

# 参照
+ [Keen IO](https://keen.io/)
+ [楽天WEB SERVICE](http://webservice.rakuten.co.jp/)
+ [Ruby SDK](http://webservice.rakuten.co.jp/sdk/ruby.html)
+ [GitHub](https://github.com/rakuten-ws/rws-ruby-sdk)
+ [[Ruby][rake]Rakeの基本的な使い方まとめ](http://d.hatena.ne.jp/unageanu/20100829/1283069269)
+ [Use environment variables in Rake task](http://stackoverflow.com/questions/15690135/use-environment-variables-in-rake-task)
+ [Heroku Scheduler](https://devcenter.heroku.com/articles/scheduler)
