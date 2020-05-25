# coding: utf-8
admin = User.find_or_initialize_by(mail: Rails.application.credentials.admin_mail)
if admin.new_record?
  admin.update!(
    name: "管理者", kana: "かんりしゃ", password: Rails.application.credentials.admin_password, gender: :man, blood_type: :o
  )
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
