$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + "/lib")

use Rack::ShowExceptions

require "git_http"

config = {
  :project_root => "/tmp/repo.git",
  :upload_pack => true,
  :receive_pack => true,
}

run GitHttp::App.new(config)