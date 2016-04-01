module Mahjong
  module Field
    class Base
      include ActiveModel::Model
      include ActiveModel::Serialization

      attr_accessor :tiles
    end

    class Hand < Field::Base
      attr_accessor :user
    end

    class River < Field::Base
      attr_accessor :user
    end

    class Wall < Field::Base
    end
  end
end
