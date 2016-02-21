require 'mechanize'

#日付を整形
def convert(num)
    if num < 10
        return "0#{num}"
        else
        return "#{num}"
    end
end


#日付取得
day = Time.now
year = convert(day.year)
month = convert(day.month)
day = convert(day.day)

#dotsのイベントページurl用の配列
dotsLinkArr = []

#dotsのイベントページをスクレイピング
agent = Mechanize.new
page = agent.get("http://eventdots.jp/event/search?start=#{year}-#{month}-#{day}")
page.links_with(:href => /\/event\/\d/).each do |link|
        dotsLinkArr.push(link.href)
end



#対象サイト配列
originalSite = ["connpass","atnd","doorkeeper"]

(0..originalSite.count-1).each do |i|
    #元サイトのイベントページurl用の配列
    originalLinkArr = []
    
    site = Regexp.new(originalSite[i])
    
    (0..dotsLinkArr.count-1).each do |j|
        page = agent.get(dotsLinkArr[j])
        page.links_with(:href => site).each do |link|
            originalLinkArr.push(link.href)
        end
        originalLinkArr = originalLinkArr.uniq
    end
    
    puts "---------------"
    puts site.to_s
    puts "---------------"
    
    #その日のイベントかどうか
    (0..originalLinkArr.count-1).each do |j|
        page = agent.get(originalLinkArr[j])
        if page.body =~ Regexp.new("#{month}/#{day}") || page.body =~ Regexp.new("#{month}-#{day}")
            puts "#{originalLinkArr[j]}  は#{month}/#{day}のイベントである"
        else
        #puts "#{originalLinkArr[j]}  は#{month}/#{day}のイベントではない"
        end
    end
end
