namespace :db do
desc "Load Database"
  task :seed do
    seeds_path = File.join(ROOT_PATH, 'db', 'seeds')
    # ruby files
    Dir["#{seeds_path}/*"].select { |file| /(rb)$/ =~ file }.sort.each {|f| require f}
  end
end