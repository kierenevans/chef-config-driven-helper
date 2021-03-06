#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'
require 'kitchen/provisioner/chef_base'
module Kitchen
  module Provisioner
    class ChefBase < Base
      private

      def berksfile
        File.join(config[:kitchen_root], "test/Berksfile")
      end
    end
  end
end

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any'],
      tags: ['~FC003', '~FC015', '~FC044'],
      exclude_paths: ['test/']
    }
  end
end

desc 'Run all style checks'
task :style => %w( style:chef style:ruby )

# Rspec and ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

# Integration tests. Kitchen.ci
namespace :integration do
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
end

task :travis => %w( style:chef spec )

task :test => %w( style:chef spec integration:vagrant )
