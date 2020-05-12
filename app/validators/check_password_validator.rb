class CheckPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    # パスワードは半角スペースを除いたASCII文字のみ
    if value.match?(/[^!-~]/)
      record.errors.add(attr, "に使えない文字が含まれています")
    end
    # パスワードには英・数・記号をそれぞれ1文字以上含まなければならない
    if value !~ /[A-Za-z]/ || value !~ /[0-9]/ || value !~ %r|[!-/:-@\[-`{-~]|
      record.errors.add(attr, "には英字・数字・記号をそれぞれ1文字以上含めてください")
    end
    # # パスワードはメールの一部の文字には設定できない
    # if record.mail&.include?(value)
    #   record.errors.add(attr, "はメールアドレスと同じにできません。")
    # end
  end
end
