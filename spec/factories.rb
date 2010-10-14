Factory.define :user do |u|
  u.name              "Johnny"
  u.sequence(:email)  { |n| "user-#{n}@getshrink.com" }
  u.password          "shrink"
end

Factory.define :project do |p|
  p.name "Shrink"
end
