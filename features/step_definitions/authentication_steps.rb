Given "I am not signed in" do
  visit destroy_user_session_path
end

Given "I am signed in" do
  Given 'I am not signed in'
  And 'I have a user with email "user@getshrink.com" and password "shrink"'
  When 'I go to the homepage'
  And 'I fill in "Email" with "user@getshrink.com"'
  And 'I fill in "Password" with "shrink"'
  And 'I press "Sign in"'
  Then 'I should see "Signed in successfully."'
  And 'I should be on the homepage'
end
