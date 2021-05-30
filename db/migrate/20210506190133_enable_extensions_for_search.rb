class EnableExtensionsForSearch < ActiveRecord::Migration[5.2]
  def change
    enable_extension "fuzzystrmatch"
    enable_extension "pg_trgm"
    enable_extension "dict_int"
  end
end
