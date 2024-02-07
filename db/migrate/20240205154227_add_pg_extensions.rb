class AddPgExtensions < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    enable_extension 'unaccent' unless extension_enabled?('unaccent')
  end
end
