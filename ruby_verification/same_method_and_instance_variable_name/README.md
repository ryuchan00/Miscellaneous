メソッドとインスタンス変数って同名いけたっけ?という調査

```ruby
  def signed_in_status
    if current_basket.nil?
      errors.add(
        :error_message,
        message: I18n.t('errors.error_message')
      )
      render_errors and return
    end

    # コレ、大丈夫?????意図して上書きしているのかな
    @signed_in_status = current_basket.signed_in_gmo_id?
  end
```

全てはここが答えに
エラー処理できないでしょ
jbuilderに渡せないでしょ的な理由

[Ruby on Railsでcontrollerがインスタンス変数を持つ理由 - Qiita](https://qiita.com/soudai_s/items/64ef824fe913be9093bb)
