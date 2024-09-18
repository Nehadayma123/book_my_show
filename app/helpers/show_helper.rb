module ShowHelper
  def date_options
    (0..7).map do |day_offset|
      date = Time.zone.now.to_date + day_offset.days
      [date.strftime('%Y-%m-%d'), date.to_s]
    end
  end
end
