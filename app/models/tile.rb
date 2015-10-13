class Tile < ActiveRecord::Base
  # https://en.wikipedia.org/wiki/Japanese_Mahjong#General_mahjong_rules
  KINDS = %i(
    wan_1
    wan_2
    wan_3
    wan_4
    wan_5
    wan_6
    wan_7
    wan_8
    wan_9
    sou_1
    sou_2
    sou_3
    sou_4
    sou_5
    sou_6
    sou_7
    sou_8
    sou_9
    wan_1
    wan_2
    wan_3
    wan_4
    wan_5
    wan_6
    wan_7
    wan_8
    wan_9
    ton
    nan
    sha
    pei
    haku
    hatsu
    chun
  )

  belongs_to :game
end
