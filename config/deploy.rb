set :application, 'berliner-hoefe'
set :repo_url, 'git@github.com:geniou/berliner-hoefe.git'

set :deploy_to, '/var/www/virtual/geni/rails/berliner-hoefe'

set :ssh_options, forward_agent: true, user: 'geni'

set :rbenv_type, :user
set :rbenv_ruby, '2.1.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  after :publishing, :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute 'svc -du ~/service/rails-berliner-hoefe'
    end
  end

  after :updating, :setup_http_auth do
    on roles(:web) do
      execute %{
        content=$(cat #{File.join(shared_path, 'auth')}); \
        sed -i "s/# http_basic_authenticate/${content}/g" \
        #{File.join(release_path, 'app', 'controllers', 'admin', 'application_controller.rb')}
      }
    end
  end
end
