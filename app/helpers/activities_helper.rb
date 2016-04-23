module ActivitiesHelper
  def get_date(activity)
    time = (Time.now - activity.updated_at).to_i
    r = if (time > 86400)
      (time/86400).to_i == 1 ? t = 'day' : t = 'days'
      "#{time/86400} #{t} ago"
    elsif (time < 86400) && (time > 3600)
      (time/3600).to_i == 1 ? t = 'hour' : t = 'hours'
      "#{time/3600} #{t} ago"
    elsif (time < 3600) && (time > 60)
      (time/60).to_i == 1 ? t = 'minute' : t = 'minutes'
      "#{time/60} #{t} ago"
    elsif (time < 60)
      'a few seconds ago'
    end
    return r
  end
end
