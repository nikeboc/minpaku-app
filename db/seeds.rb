# メインのサンプルユーザーを1人作成する
User.create!(name:  "sample",
             email: "example@sample.com",
             password:              "samplesample",
             password_confirmation: "samplesample",
             admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@sample.com"
  password = "passwordqwer"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end