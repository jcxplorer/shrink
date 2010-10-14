require 'net/http'

namespace :notification do

  task :fake => :environment do
    project_tokens  = Project.select(:token).map(&:token)
    random_token    = project_tokens[rand(project_tokens.count)]
    xml             = Nokogiri::XML(File.read(Rails.root.join("spec/samples/notification.xml")))
    url             = URI.parse("http://127.0.0.1:8080/api/v1/notifications")

    xml.at_xpath("/notification/token").content = random_token
    
    Net::HTTP.start(url.host, url.port) do |http|
      http.post(url.path, xml.to_s, { "Content-Type" => "text/xml" })
    end
  end

end
