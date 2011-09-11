ENV["APP_ROOT"] = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift  ENV["APP_ROOT"] + "/lib"

use Rack::ShowExceptions

require "git_http"

# Try vendored git, and fall back to system if wrong format
begin
  git_path = ENV["APP_ROOT"] + "/git/bin/git"
  `#{git_path} --version`
rescue Errno::ENOEXEC
  git_path = `which git`.strip
end

config = {
  :git_path => git_path,
  :project_root => "/tmp/repo.git",
  :receive_pack => true,
  :upload_pack => true,
}

run GitHttp::App.new(config)