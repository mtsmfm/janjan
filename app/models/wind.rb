class Wind
  WINDS = %i(east south west north)
  WINDS_ENUM_HASH = WINDS.zip(WINDS.map(&:to_s)).to_h

  delegate :inspect, :to_s, to: :@wind_str

  def initialize(wind_str)
    @wind_str = wind_str
  end

  def next
    WINDS.zip(WINDS.rotate).to_h.with_indifferent_access[to_s]
  end
end
