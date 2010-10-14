When /^the application receives the sample notification XML$/ do
  xml = Nokogiri::XML(File.read(Rails.root.join("spec/samples/notification.xml")))
  xml.at_xpath("/notification/token").content = @project.token
  
  post api_v1_notifications_path, xml.to_s, { "CONTENT_TYPE" => "application/xml" }
end

