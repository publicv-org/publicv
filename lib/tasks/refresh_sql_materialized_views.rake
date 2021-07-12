namespace :refresh do
  desc 'Refresh sql materialized views'
  task sql_materialized_views: :environment do
    SearchableCv.refresh
  end
end
