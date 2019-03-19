require 'factory_bot'

Spree::Zone.class_eval do
  def self.global
    find_by(name: 'GlobalZone') || FactoryBot.create(:global_zone)
  end
end

Dir[File.join(__dir__, 'factories', '**')].each do |file|
  require File.expand_path(file)
end

FactoryBot.define do
  sequence(:random_string)      { Faker::Lorem.sentence }
  sequence(:random_description) { Faker::Lorem.paragraphs(1 + Kernel.rand(5)).join("\n") }
  sequence(:random_email)       { Faker::Internet.email }
end
