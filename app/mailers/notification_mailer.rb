class NotificationMailer < ApplicationMailer

  def send_confirm_to_user(user)
    @user = user
    mail to: user.email, subject: "会員登録が完了しました"
  end
end
