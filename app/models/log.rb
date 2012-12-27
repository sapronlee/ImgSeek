class Log < ActiveRecord::Base
  attr_accessible :ip, :msg, :time
end
