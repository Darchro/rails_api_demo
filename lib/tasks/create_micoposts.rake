namespace :data do
  task :create_microposts => [:environment] do
    user = User.find(1)
    100.times do |i|
      Micropost.create(user_id: user.id, content: "content-#{i}")
    end
  end
end