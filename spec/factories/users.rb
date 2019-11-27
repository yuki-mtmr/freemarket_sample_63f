FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"jflgf743a"}
    last_name             { "阿部" }
    first_name            { "赤次郎" }
    last_name_kana        { "アベ" }
    first_name_kana       { "アカジロウ" }
    birth_year            { 2002 }
    birth_month           { 8 }
    birth_day             { 31 }
    phone_number          { "09000000000" }
  end

end