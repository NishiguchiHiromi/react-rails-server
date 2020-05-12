# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # 下記origin以外でももしプリフライトリクエストが発生しなければリクエストは成立し、サーバーサイドでの処理も行われる！
    # ただ、下記oprigin以外ではレスポンスを読み込めない
    origins 'http://localhost:4200'

    resource '*',
      # カスタムヘッダを許容
      # プリフライトリクエストのAccess-Control-Request-Headers（ブラウザが勝手に付与）を照らし合わせて
      # 問題なければAccess-Control-Allow-Headersを返す
      headers: ['My-Header'],
      # メソッドを許容
      # プリフライトリクエストのAccess-Control-Request-Method（ブラウザが勝手に付与）を照らし合わせて
      # 問題なければAccess-Control-Allow-Methodsを返す
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
