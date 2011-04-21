require 'rails/generators'
require 'rails/generators/migration'

module Omnisocial
  module Generators
    class OmnisocialGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Creates an omnisocial initializer and migration, and copies image and CSS assets.'

      def self.source_root
        File.join(File.dirname(__FILE__), 'templates')
      end

      def copy_initializer
        template 'omnisocial.rb', 'config/initializers/omnisocial.rb'
      end

      def copy_user_model
        template 'user.rb', 'app/models/user.rb'
      end

      def copy_assets
        copy_file 'assets/stylesheets/omnisocial.css',  'public/stylesheets/omnisocial.css'
      end

      def show_readme
        readme 'README' if behavior == :invoke
      end
    end
  end
end
