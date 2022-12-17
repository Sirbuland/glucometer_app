# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :user do
    pass = "YF6spnA+KtE:GDGK"
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { pass }
    password_confirmation { pass }
  end
end