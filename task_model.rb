require 'couchrest_model'

class Task < CouchRest::Model::Base
  view_by :created_at
  view_by :complete

  property :created_at
  property :complete
  property :task
end
