module FoundationRailsTestHelpers
  def create_dummy_app
    Dir.chdir(tmp_path) do
      Bundler.with_clean_env do
        `rails new dummy --skip-active-record --skip-test-unit --skip-spring --skip-bundle`
      end
      File.open(dummy_app_path + '/Gemfile', 'a') do |f|
        f.puts "gem 'foundation-rails', path: '#{File.join(File.dirname(__FILE__), '..', '..')}'"
      end
    end
    Dir.chdir(dummy_app_path) do
      Bundler.with_clean_env do
        `bundle install`
      end
    end
  end

  def remove_dummy_app
    FileUtils.rm_rf(dummy_app_path)
  end

  def install_foundation
    Dir.chdir(dummy_app_path) do
      Bundler.with_clean_env do
        `rails g foundation:install -f 2>&1`
      end
    end
  end

  def dummy_app_path
    File.join(tmp_path, 'dummy')
  end

  def tmp_path
    @tmp_path ||= File.join(File.dirname(__FILE__), '..')
  end
end
