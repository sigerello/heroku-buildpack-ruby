require 'language_pack/installers/ruby_installer'
require 'language_pack/base'
require 'language_pack/shell_helpers'

class LanguagePack::Installers::HerokuRubyInstaller
  include LanguagePack::ShellHelpers, LanguagePack::Installers::RubyInstaller

  BASE_URL = LanguagePack::Base::VENDOR_URL

  def initialize(stack)
    @fetcher = LanguagePack::Fetcher.new(BASE_URL, stack)
  end

  def fetch_unpack(ruby_version, install_dir, build = false)
    if ruby_version.version == "ruby-1.9.3-p551" || ruby_version.version == "ruby-1.9.3"
      base_url = "https://cache.ruby-lang.org/pub/ruby/1.9"
      file = "ruby-1.9.3-p551.tar.gz"
      fetcher = LanguagePack::Fetcher.new(base_url)
    else
      file = "#{ruby_version.version_for_download}.tgz"
      fetcher = @fetcher
    end

    FileUtils.mkdir_p(install_dir)
    Dir.chdir(install_dir) do
      if build
        ruby_vm = "ruby"
        file.sub!(ruby_vm, "#{ruby_vm}-build")
      end
      fetcher.fetch_untar(file)
    end
  end
end

