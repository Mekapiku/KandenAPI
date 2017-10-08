require 'capybara/poltergeist'
require "./config"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 5000 })
end

# サイトにアクセス
session = Capybara::Session.new(:poltergeist)
session.visit "https://kepco.jp/miruden/ServiceTop/Login"

# ログイン情報を入力
email_input = session.find('input#container_0_subcontainer_0_maincontent_0_UserID')
email_input.native.send_key($user_id)

password_input = session.find('input#container_0_subcontainer_0_maincontent_0_Password')
password_input.native.send_key($password)

submit = session.find('#container_0_subcontainer_0_maincontent_0_Login')
submit.click

# 最新の料金データを出力
ret = session.all('dd.u-text-XXXL')

out = {
    "kanden" => {
	"this_month" => ret[0].text,
        "diff_last_month" => ret[1].text,
        "diff_last_year" => ret[2].text
    }
}

File.write(ARGV[0], out.to_json)

# 各種データダウンロードページまで遷移
#session.visit "https://kepco.jp/miruden/MyPage/Download"

# TODO: これではダウンロードできない...
#session.find('#container_0_subcontainer_0_maincontent_1_MonthlyDownloadButton').click
