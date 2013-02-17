# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  Party      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:todo) do
  Party "MyString"
end
