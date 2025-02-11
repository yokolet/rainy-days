# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

def seedUsers(emails, providers, uids)
  users = [
    {
      email: emails[0],
      provider: providers[0],
      uid: uids[0],
    },
    {
      email: emails[1],
      provider: providers[1],
      uid: uids[1],
    },
    {
      email: emails[2],
      provider: providers[2],
      uid: uids[2],
    },
    {
      email: emails[3],
      provider: providers[3],
      uid: uids[3],
    },
    {
      email: emails[4],
      provider: providers[4],
      uid: uids[4],
    },
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
      title: "The Daffodil Sky",
      content: "Architecto atque quia. Voluptates ullam aut. Repudiandae delectus explicabo."
    },
    {
      user_id: user_ids[1],
      title: "Recalled to Life",
      content: "Harum dolor impedit. Quo iste officia. Et ab nulla."
    },
    {
      user_id: user_ids[2],
      title: "Fair Stood the Wind for France",
      content: "Mollitia et consectetur. Et porro harum. Beatae facere quisquam."
    },
    {
      user_id: user_ids[3],
      title:  "Down to a Sunless Sea",
      content: "Vero architecto quia. Et tenetur exercitationem. Dolor laborum corrupti."
    },
  ]

  Post.upsert_all(posts)
end

def seedComments(emails, providers)
  user_ids = emails.zip(providers).map do |email, p|
    User.where(email: email, provider: p).first.id
  end
  post_ids = Post.where(user_id: user_ids).map {|e| e.id}
  comments = [
    {
      user_id: user_ids[0],
      post_id: post_ids[3],
      body: "Quaerat accusantium eum dicta."
    },
    {
      user_id: user_ids[1],
      post_id: post_ids[2],
      body: "Dolorum veniam qui laborum."
    },
    {
      user_id: user_ids[2],
      post_id: post_ids[1],
      body: "Ipsam quisquam voluptatem iure."
    },
    {
      user_id: user_ids[3],
      post_id: post_ids[0],
      body: "Debitis hic consequatur voluptatem."
    },
  ]
  Comment.upsert_all(comments)
  first_comments = Comment.where(post_id: post_ids)
  replies = [
    {
      user_id: user_ids[1],
      post_id: first_comments[0].post_id,
      reply_id: first_comments[0].id,
      body: "Qui est omnis laudantium.",
    },
    {
      user_id: user_ids[2],
      post_id: first_comments[1].post_id,
      reply_id: first_comments[1].id,
      body: "Non qui beatae iusto.",
    }
  ]
  Comment.upsert_all(replies)
end

emails = ["rank@koelpin.test", "waldo.reynolds@nikolaus.test", "lessie@hegmann-kuhlman.example",
               "fumiko@weber.example", "evalyn.macejkovic@torp.example"]
providers = [:google, :gitlab, :github, :google, :github]
uids = ["dweirzniu8ghppw54ueswh4leby66kek", "55wy0jaoedlmt9yo", "dy4frnvn85",
        "qwzzh3xea0hsr5la", "ggqz1vjbd72a35bl8wmj4ym1"]

seedUsers(emails, providers, uids)
seedPosts(emails, providers)
seedComments(emails, providers)
