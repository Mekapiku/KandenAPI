$:.unshift File.dirname(__FILE__)

require 'capybara/poltergeist'
require 'nokogiri'
require 'date'

require 'config'

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
page = Nokogiri::HTML.parse(session.html)
table = page.css('.panel-pricedisplay__left').first
left_table = table.css('.panel-pricedisplay__item').first
right_table = table.css('.panel-pricedisplay__item.__item-P02').first

this_month = Date.strptime(left_table.xpath('dd').first.children.last, "%Y年%m月分")
this_month_price = left_table.xpath('dd')[1].text.gsub(/,|円/, "").to_i

diff_last_month = right_table.xpath('dd').first.text.gsub(/,|円/, "").to_i
diff_last_year = right_table.xpath('dd').last.text.gsub(/,|円/, "").to_i

out = {
    "kanden" => {
        "date" => this_month,
	      "price" => this_month_price,
        "diff_last_month" => diff_last_month,
        "diff_last_year" => diff_last_year
    }
}

File.write(ARGV[0], out.to_json)

# 各種データダウンロードページまで遷移
#session.visit "https://kepco.jp/miruden/MyPage/Download"

# TODO: これではダウンロードできない...
#session.find('#container_0_subcontainer_0_maincontent_1_MonthlyDownloadButton').click
