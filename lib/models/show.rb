require "active_record"

class Show < ActiveRecord::Base
  MIN_LAST_UPDATE = 3600

  scope :need_be_update, -> { where('last_update >= ? OR last_update is null', MIN_LAST_UPDATE) }
end
