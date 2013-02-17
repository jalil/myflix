# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  Party      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Todo < ActiveRecord::Base
  attr_accessible :Party
end
