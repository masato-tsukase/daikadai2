class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
  def sendmail_blog(tweet)
    @tweet = tweet

    mail to: "masax0408@yahoo.co.jp",
         subject: '【Instagram】投稿されました'
  end
end
