day = Time.now

def convert(num)
    if num < 10
        return "0#{num}"
    else
        return "#{num}"
    end
end

year = day.year
month = convert(day.month)
day =  convert(day.day)

a = "#{year}/#{month}/#{day}"
p Regexp.new(a)



def is?()
    p "aa"
end

is?