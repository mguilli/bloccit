class FavoriteMailer < ActionMailer::Base
  default from: "mguilli@mguilli-bloccit.example"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@mguilli-bloccit.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@mguilli-bloccit.example>"
    headers["References"] = "<post/#{post.id}@mguilli-bloccit.example>"

    @user = user
    @post = post
    @comment = comment
    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
