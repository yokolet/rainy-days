# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def seedUsers(emails, providers, usernames)
  users = [
    {
      email: emails[0],
      provider: providers[0],
      username: usernames[0]
    },
    {
      email: emails[1],
      provider: providers[1],
      username: usernames[1]
    },
    {
      email: emails[2],
      provider: providers[2],
      username: usernames[2]
    },
    {
      email: emails[3],
      provider: providers[3],
      username: usernames[3]
    },
    {
      email: emails[4],
      provider: providers[4],
      username: usernames[4]
    }
  ]

  User.upsert_all(
    users,
    on_duplicate: :update,
    update_only: :provider,
    unique_by: 'lower((email)::text)'
  )
end

def seedPosts(emails, providers)
  user_ids = emails.zip(providers).map do |email, p|
    User.where(email: email, provider: p).first.id
  end

  posts = [
    {
      user_id: user_ids[0],
      title: "For ever and a day.",
      content: "All the world's a stage, and all the men and women merely players; they have their exits and their entrances, and one man in his time plays many parts, his acts being seven ages."
    },
    {
      user_id: user_ids[1],
      title: "I will speak daggers to her but use none.",
      content: "Doubt thou the stars are fire, doubt that the sun doth move, doubt truth to be a liar, but never doubt I love."
    },
    {
      user_id: user_ids[2],
      title: "An honest tale speeds best, being plainly told.",
      content: "Conscience is but a word that cowards use, devised at first to keep the strong in awe."
    },
    {
      user_id: user_ids[3],
      title:  "Tempt not a desperate man.",
      content: "Good night, good night! Parting is such sweet sorrow, that I shall say good night till it be morrow."
    },
    {
      user_id: user_ids[4],
      title:  "Wisely and slow; they stumble that run fast.",
      content: "See how she leans her cheek upon her hand. Oh, that I were a glove upon that hand that I might touch that cheek!"
    }
  ]

  Post.upsert_all(posts)
end

def seedComments
  user_ids = User.all.map { |u| u.id }    # five users exist
  post_ids = Post.all.map { |e| e.id }    # five posts exist
  comments = [
    {
      user_id: user_ids[0],
      post_id: post_ids[0],
      body: "The highest function of ecology is understanding consequences."
    },
    {
      user_id: user_ids[1],
      post_id: post_ids[0],
      body: "The mystery of life isn't a problem to solve, but a reality to experience."
    },
    {
      user_id: user_ids[2],
      post_id: post_ids[0],
      body: "But I can tell you, dear God, for the father, nothing."
    },
    {
      user_id: user_ids[3],
      post_id: post_ids[1],
      body: "Bring in that floating fat man, the Baron!"
    },
    {
      user_id: user_ids[4],
      post_id: post_ids[1],
      body: "And you, my son, are you one who gives or one who takes?"
    },
    {
      user_id: user_ids[3],
      post_id: post_ids[2],
      body: "I made my peace gesture. The forms of kanly have been obeyed!"
    },
    {
      user_id: user_ids[2],
      post_id: post_ids[4],
      body: "Knowing where the trap is—that's the first step in evading it."
    }
  ]
  Comment.upsert_all(comments)
end

def seedReplies
  user_ids = User.all.map { |u| u.id }    # five users exist
  post_ids = Comment.select(:post_id).group(:post_id).having("count(comments.id) > 1").map { |c| c.post_id }
  comments_0 = Comment.where(post_id: post_ids[0])
  replies = [
    {
      user_id: user_ids[0],
      post_id: post_ids[0],
      reply_id: comments_0[0].id,
      body: "My dear Piter, your pleasures are what tie you to me. How could I object to that?"
    },
    {
      user_id: user_ids[1],
      post_id: post_ids[0],
      reply_id: comments_0[1].id,
      body: "The spice must flow"
    }
  ]
  comments_1 = Comment.where(post_id: post_ids[1])
  replies << {
    user_id: user_ids[2],
    post_id: post_ids[1],
    reply_id: comments_1[0].id,
    body: "Bring in that floating fat man, the Baron!"
  }
  Comment.upsert_all(replies)
end

emails = [ "rank@koelpin.test", "waldo.reynolds@nikolaus.test", "lessie@hegmann-kuhlman.example",
               "fumiko@weber.example", "evalyn.macejkovic@torp.example" ]
providers = [ :google, :gitlab, :github, :google, :github ]
usernames = [ "Amber", "dannette.rau", "clemencia",
        "Teri", "latia.streich" ]

seedUsers(emails, providers, usernames)
seedPosts(emails, providers)
seedComments()
seedReplies()
