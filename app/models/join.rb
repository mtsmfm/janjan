# == Schema Information
#
# Table name: joins
#
#  id         :integer          not null, primary key
#  user_id    :uuid             not null
#  room_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_joins_on_room_id  (room_id)
#  index_joins_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_85ae8f2798  (user_id => users.id)
#  fk_rails_8e87537561  (room_id => rooms.id)
#

class Join < ApplicationRecord
  belongs_to :user
  belongs_to :room, counter_cache: true
end
