module dobxcheck
  def date_of_birth
    dob = self.dob
    sep1 = dob[2,1].to_s
    sep2 = dob[5,1].to_s
    if (dob.length == 10) && (sep1 == '/' && sep2 == '/') 
      day  = dob[0,2].to_i if day.to_i.is_a? Numeric
      mon  = dob[3,2].to_i if mon.to_i.is_a? Numeric
      year = dob[6,4].to_i if year.to_i.is_a? Numeric
      if (mon < 1 || mon > 12)
        errors.add :base, 'Enter correct month'
      else
        if (year <= 1900) || (year >= (Date.today.year - 10))
          errors.add :base, 'Enter valid year, minimum age should be 10 years'
        else
          validate_days mon, day
        end
      end
    else
      errors.add :base, 'Enter date in valid format'
    end
  end

  def validate_days(mon, days)
    case mon
    when 1 || 3 || 5 || 7 || 8 || 10 || 12
      month_days days, 31
    when 02
      if Date.leap year
        month_days days, 29
      else
        month_days days, 28
      end
    when 4 || 6 || 9 || 11
      month_days days, 30
    end
  end

  def month_days(days, month_days)
    if (days < 1) || (days > month_days)
      errors.add :base, "Enter correct day"
    end
  end
end