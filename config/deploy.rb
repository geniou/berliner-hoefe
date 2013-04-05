require 'bundler/capistrano'

ssh_options[:forward_agent] = true

set :application, "berliner-hoefe"
set :repository,  "git@bitbucket.org:geni/berliner-hoefe.git"

server "phoenix.uberspace.de", :app, :web, :db, :primary => true

set :deploy_to,  '/var/www/virtual/geni/rails/berliner-hoefe'

after "deploy:restart", "deploy:cleanup"

set :bundle_without,  [ :development, :test ]

set :default_environment, {
    'PATH' => "~/.rbenv/shims:~/.rbenv/bin:$PATH"
}

set :use_sudo, false

namespace :uberspace do
  desc 'Kills running server, to be restarted automaticly'
  task(:restart) { run "kill $(cat #{shared_path}/pids/server.pid)" }
end
after 'deploy:create_symlink', 'uberspace:restart'